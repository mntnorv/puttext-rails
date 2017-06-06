# frozen_string_literal: true

require 'spec_helper'
require 'fileutils'
require 'puttext-rails/extractor'

describe PutText::Rails::Extractor do
  describe '#extract' do
    before do
      FileUtils.mkdir_p('/tmp/puttext-rails/config/locales')

      allow(Rails).to receive(:root).and_return(
        Pathname.new('/tmp/puttext-rails')
      )

      Timecop.freeze(Time.utc(2017))
      Time.zone = 'UTC'
    end

    after do
      Timecop.return
    end

    let(:extracted_entries) { subject.extract.entries }

    context 'I18n backend is I18n::Backend::Simple' do
      let(:backend) { I18n::Backend::Simple.new }

      before { allow(I18n).to receive(:backend).and_return(backend) }

      context 'Backend has translations for validation errors' do
        before do
          allow(backend).to receive(:translations).and_return(
            en: {
              errors: {
                messages: {
                  message_1: 'Something is invalid',
                  message_2: {
                    one: '1 error occurred',
                    other: '%{count} errors occurred'
                  }
                }
              }
            }
          )
        end

        it 'returns POFile with the extracted error messages' do
          expect(extracted_entries).to contain_exactly(
            PutText::POEntry.new(
              msgctxt: 'Validation error',
              msgid: 'Something is invalid'
            ),
            PutText::POEntry.new(
              msgctxt: 'Validation error',
              msgid: '1 error occurred',
              msgid_plural: '%{count} errors occurred'
            )
          )
        end
      end

      context 'Backend doesn\'t have validation error translations' do
        before { allow(backend).to receive(:translations).and_return({}) }

        it 'returns empty POFile' do
          expect(extracted_entries).to eq []
        end
      end
    end

    context 'I18n backed is not a I18n::Backend::Simple' do
      let(:backend) { double('Unsupported backend') }

      before { allow(I18n).to receive(:backend).and_return(backend) }

      it 'raises an error' do
        expect { subject.extract }.to raise_error(
          'only I18n::Backend::Simple is supported'
        )
      end
    end
  end
end
