Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5199A29EED6
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Oct 2020 15:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJ2Oyf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Oct 2020 10:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbgJ2Oyf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 29 Oct 2020 10:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603983273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2B8ESx3Qkgg174WkgZxum9Jq8NvJ5VbQ8kTa3ijDSQ=;
        b=BwfjVR123r5XpyPuR1jh84CRqH1cWoabERBIvrOh7kdBcybyKIdxytG05VrtvOjDz+YfQ7
        UHXfMlIOgZSqVYDBC+rrgOSdNu7irgVzP/Z3eWX6C9oO3QXv1wmtN051Znmba1IfnFRoo6
        JyF76bK905eZnE/AeEqjjgjhFVqkJ7k=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-BuLXzoBnM2SmS_IQ5WaNww-1; Thu, 29 Oct 2020 10:54:31 -0400
X-MC-Unique: BuLXzoBnM2SmS_IQ5WaNww-1
Received: by mail-ot1-f72.google.com with SMTP id h7so1061825otn.10
        for <linux-fpga@vger.kernel.org>; Thu, 29 Oct 2020 07:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u2B8ESx3Qkgg174WkgZxum9Jq8NvJ5VbQ8kTa3ijDSQ=;
        b=MrtmKuBQqjEHntyf07aK1cLedBPUTV4VfB/VmEeXfWfpv8TS8ydg3eoatOoQdcr0QN
         TnuUBI8ichZBFNvFZxPiyO65JFIqAcvNP+8GswhDds3NxcMG/vFq6O56MPdFJ/TvjVAW
         DjAiWEzuElV0NSfD6qqa4tmtg5XHU6iU+CU6GBLok7v7+f/X7gV2U3KlyNYtR2o+R466
         ryi9rKEzlK2fW2wXV7rb0VfLFjI1tc8J72292f1mhZn3CXDdBADI0GbuWID1+2QnVc0L
         5bkl8I9gp6JTcX9AvVRFKE3Wk1nwG5HsCzvbv9aYvj6/HQMWVkW+zwoqYVRjFEs1V0zW
         QExw==
X-Gm-Message-State: AOAM530VC5saP+Dxe5R0mCdpUmmG+Kt7cV+bj5CaA1Ftgndj7FfB/L1z
        9digrbXho+Yt2B0PDpCv+NPp208EeUqp7KhhxrVcHyD+IxvUZxQbwP5AHQlnxD0rTaUHeHLy4RB
        C28Dq/fd0H5E/JlUPYToe+w==
X-Received: by 2002:a05:6808:9ba:: with SMTP id e26mr128047oig.101.1603983270423;
        Thu, 29 Oct 2020 07:54:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRaXWMpqfFf1Cl9gwk2vGF4covuwcFLqFvFx471Uw57Y7xr3H546rVzodSQDve2ptDRn10Pw==
X-Received: by 2002:a05:6808:9ba:: with SMTP id e26mr128027oig.101.1603983270189;
        Thu, 29 Oct 2020 07:54:30 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d64sm680303oia.11.2020.10.29.07.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:54:29 -0700 (PDT)
Subject: Re: [PATCH 30/33] docs: ABI: cleanup several ABI documents
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
 <95ef2cf3a58f4e50f17d9e58e0d9440ad14d0427.1603893146.git.mchehab+huawei@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <700bedb2-d2c8-db23-9946-88c8b2bda296@redhat.com>
Date:   Thu, 29 Oct 2020 07:54:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <95ef2cf3a58f4e50f17d9e58e0d9440ad14d0427.1603893146.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/28/20 7:23 AM, Mauro Carvalho Chehab wrote:
> There are some ABI documents that, while they don't generate
> any warnings, they have issues when parsed by get_abi.pl script
> on its output result.
>
> Address them, in order to provide a clean output.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/ABI/obsolete/sysfs-class-dax    |   8 +-
>  .../ABI/obsolete/sysfs-driver-hid-roccat-pyra |   3 +
>  Documentation/ABI/removed/devfs               |   1 +
>  Documentation/ABI/removed/raw1394             |   1 +
>  Documentation/ABI/removed/sysfs-class-rfkill  |   2 +-
>  Documentation/ABI/removed/video1394           |   1 +
>  Documentation/ABI/stable/firewire-cdev        |  63 ++---
>  Documentation/ABI/stable/sysfs-acpi-pmprofile |   4 +-
>  Documentation/ABI/stable/sysfs-bus-w1         |   1 +
>  Documentation/ABI/stable/sysfs-class-tpm      |   4 +-
>  Documentation/ABI/stable/sysfs-driver-speakup |   4 +
>  Documentation/ABI/testing/configfs-most       | 135 +++++++----
>  .../ABI/testing/configfs-usb-gadget-ecm       |  12 +-
>  .../ABI/testing/configfs-usb-gadget-eem       |  10 +-
>  .../ABI/testing/configfs-usb-gadget-loopback  |   6 +-
>  .../testing/configfs-usb-gadget-mass-storage  |  18 +-
>  .../ABI/testing/configfs-usb-gadget-midi      |  14 +-
>  .../ABI/testing/configfs-usb-gadget-printer   |   6 +-
>  .../testing/configfs-usb-gadget-sourcesink    |  18 +-
>  .../ABI/testing/configfs-usb-gadget-subset    |  10 +-
>  .../ABI/testing/configfs-usb-gadget-uac2      |  14 +-
>  .../ABI/testing/configfs-usb-gadget-uvc       |   2 +-
>  .../ABI/testing/debugfs-cec-error-inj         |   2 +-
>  .../ABI/testing/debugfs-driver-habanalabs     |  12 +-
>  .../ABI/testing/debugfs-pfo-nx-crypto         |  28 +--
>  Documentation/ABI/testing/debugfs-pktcdvd     |   2 +-
>  .../ABI/testing/debugfs-turris-mox-rwtm       |  10 +-
>  Documentation/ABI/testing/debugfs-wilco-ec    |  21 +-
>  Documentation/ABI/testing/dell-smbios-wmi     |  32 +--
>  Documentation/ABI/testing/gpio-cdev           |  13 +-
>  Documentation/ABI/testing/procfs-diskstats    |   6 +-
>  Documentation/ABI/testing/procfs-smaps_rollup |  48 ++--
>  Documentation/ABI/testing/pstore              |  19 +-
>  Documentation/ABI/testing/sysfs-block-rnbd    |   4 +-
>  Documentation/ABI/testing/sysfs-bus-acpi      |   1 +
>  .../testing/sysfs-bus-coresight-devices-etb10 |   5 +-
>  Documentation/ABI/testing/sysfs-bus-css       |   3 +
>  Documentation/ABI/testing/sysfs-bus-dfl       |   2 +
>  .../sysfs-bus-event_source-devices-hv_24x7    |   6 +-
>  .../sysfs-bus-event_source-devices-hv_gpci    |   7 +-
>  Documentation/ABI/testing/sysfs-bus-fcoe      |  68 ++++--
>  Documentation/ABI/testing/sysfs-bus-fsl-mc    |  12 +-
>  .../ABI/testing/sysfs-bus-i2c-devices-fsa9480 |  26 +-
>  Documentation/ABI/testing/sysfs-bus-i3c       |   2 +
>  Documentation/ABI/testing/sysfs-bus-iio       |  19 +-
>  .../ABI/testing/sysfs-bus-iio-adc-hi8435      |   5 +
>  .../ABI/testing/sysfs-bus-iio-adc-stm32       |   3 +
>  .../ABI/testing/sysfs-bus-iio-distance-srf08  |   7 +-
>  .../testing/sysfs-bus-iio-frequency-ad9523    |   2 +
>  .../testing/sysfs-bus-iio-frequency-adf4371   |  10 +-
>  .../ABI/testing/sysfs-bus-iio-health-afe440x  |  12 +-
>  .../ABI/testing/sysfs-bus-iio-light-isl29018  |   6 +-
>  .../testing/sysfs-bus-intel_th-devices-gth    |  11 +-
>  Documentation/ABI/testing/sysfs-bus-papr-pmem |  23 +-
>  Documentation/ABI/testing/sysfs-bus-pci       |  22 +-
>  .../ABI/testing/sysfs-bus-pci-devices-catpt   |   1 +
>  .../testing/sysfs-bus-pci-drivers-ehci_hcd    |   4 +-
>  Documentation/ABI/testing/sysfs-bus-rbd       |  37 ++-
>  Documentation/ABI/testing/sysfs-bus-siox      |   3 +
>  .../ABI/testing/sysfs-bus-thunderbolt         |  18 +-
>  Documentation/ABI/testing/sysfs-bus-usb       |   2 +
>  .../sysfs-class-backlight-driver-lm3533       |  26 +-
>  Documentation/ABI/testing/sysfs-class-bdi     |   1 -
>  .../ABI/testing/sysfs-class-chromeos          |  15 +-
>  Documentation/ABI/testing/sysfs-class-cxl     |   8 +-
>  Documentation/ABI/testing/sysfs-class-devlink |  30 ++-
>  Documentation/ABI/testing/sysfs-class-extcon  |  34 +--
>  .../ABI/testing/sysfs-class-fpga-manager      |   5 +-

The fpga-manager change looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>



