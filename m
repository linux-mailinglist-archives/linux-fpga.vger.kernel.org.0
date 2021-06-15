Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C073A8A14
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Jun 2021 22:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFOUVX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Jun 2021 16:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229931AbhFOUVX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Jun 2021 16:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623788358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OP+kXa7j7VmEib/1s/iK6tFrNtW3KF8Er88jDxAmgM=;
        b=DO0IxwWhjeCIu+yRi/TTtDYD9b801edmASR+BANJ105O09rrTPkncscWQcslsfM1sBNa7W
        BxHcHYJ/dtyDzM05KaHU49Mu5zKBiU97vFYKOS4vk+5vgl7kk60vi/KicZvvS2x369Z/ax
        e897BZeTzqEjP/J+IzMq1otnt7OErzg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-rZ4_s8LpP0K378ADheSI6w-1; Tue, 15 Jun 2021 16:19:16 -0400
X-MC-Unique: rZ4_s8LpP0K378ADheSI6w-1
Received: by mail-oi1-f198.google.com with SMTP id x125-20020aca31830000b02901f1c37dd8c9so8337767oix.8
        for <linux-fpga@vger.kernel.org>; Tue, 15 Jun 2021 13:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4OP+kXa7j7VmEib/1s/iK6tFrNtW3KF8Er88jDxAmgM=;
        b=eJqRkWbmcvQI5TrAGj7xpCtFuA+OZucA5dpRlG+h4MDIaje+jcddDgfktRpv54fmbt
         6e1A+i2O+R29xip37wXrqPiLDjwMgEZTqCQsjjsm8t4FSgE2bRmbZssvwSlzTBcdGvmo
         41jFEyRLSxaP36KTvQfueDWnbnL/1OL4nR1MEAYGxQ31W1r5ItuGLAYUgHiK5z8Gc9JI
         qm3thOpCn/r4QzoH03eQ9BxPKktVIp7XAxN1n4sL3cxwSW7uPLbrgn0NyIB1/pq/vcKB
         Q23f/Qilsr4ZfPTRoc6qi9wre68OTZqTRgeUglLBDswCGpaFX+yusnjru8UAmwBGAnrG
         trcA==
X-Gm-Message-State: AOAM5333ffh9uWDZW4NQJ3UiA4qGag6YFPcQS1l2qydgwG5Wwi/Nfjdd
        HJdJUpBSFtj6VN3xESxTKsqXk+tIApRxco9fohjEk5PJBA9oxAmPUXFgjE9XYKvU09sQXPdxBOn
        Vtx4DbVReIyHjGq4kO6XhYA==
X-Received: by 2002:aca:3116:: with SMTP id x22mr4505079oix.133.1623788356051;
        Tue, 15 Jun 2021 13:19:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwwPbnuyI6YudjokAwUqRQtYf1k04oNrXQJJvSmUCF56DnYq438Sd2W0glU3maXdkqoYw/Ug==
X-Received: by 2002:aca:3116:: with SMTP id x22mr4505062oix.133.1623788355771;
        Tue, 15 Jun 2021 13:19:15 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v1sm1926804ota.22.2021.06.15.13.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 13:19:14 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] fpga: xilinx: reorganize to subdir layout
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, krzysztof.kozlowski@canonical.com,
        nava.manne@xilinx.com, yilun.xu@intel.com, davidgow@google.com,
        fpacheco@redhat.com, richard.gong@intel.com, luca@lucaceresoli.net,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210614201648.3358206-1-trix@redhat.com>
 <20210614201648.3358206-4-trix@redhat.com> <YMhYfCgOAthEqPXs@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4fa2a233-e429-1b41-fc9b-1f4c6d9a05ae@redhat.com>
Date:   Tue, 15 Jun 2021 13:19:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMhYfCgOAthEqPXs@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/15/21 12:36 AM, Greg KH wrote:
> On Mon, Jun 14, 2021 at 01:16:46PM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Follow drivers/net/ethernet/ which has control configs
>> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
>> Since fpgas do not have many vendors, drop the 'VENDOR' and use
>> FPGA_BLA.
>>
>> There are several new subdirs
>> altera/
>> dfl/
>> lattice/
>> xilinx/
>>
>> Each subdir has a Kconfig that has a new/reused
>>
>> if FPGA_BLA
>>    ... existing configs ...
>> endif FPGA_BLA
>>
>> Which is sourced into the main fpga/Kconfig
>>
>> Each subdir has a Makefile whose transversal is controlled in the
>> fpga/Makefile by
>>
>> obj-$(CONFIG_FPGA_BLA) += bla/
>>
>> This is the xilinx/ subdir part
>>
>> Create a xilinx/ subdir
>> Move xilinx-* and zynq* files to it.
>> Add a Kconfig and Makefile
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/Kconfig                          | 40 +-------------
>>   drivers/fpga/Makefile                         |  5 +-
>>   drivers/fpga/xilinx/Kconfig                   | 55 +++++++++++++++++++
>>   drivers/fpga/xilinx/Makefile                  |  6 ++
>>   .../fpga/{ => xilinx}/xilinx-pr-decoupler.c   |  0
>>   drivers/fpga/{ => xilinx}/xilinx-spi.c        |  0
>>   drivers/fpga/{ => xilinx}/zynq-fpga.c         |  0
>>   drivers/fpga/{ => xilinx}/zynqmp-fpga.c       |  0
>>   8 files changed, 63 insertions(+), 43 deletions(-)
>>   create mode 100644 drivers/fpga/xilinx/Kconfig
>>   create mode 100644 drivers/fpga/xilinx/Makefile
>>   rename drivers/fpga/{ => xilinx}/xilinx-pr-decoupler.c (100%)
>>   rename drivers/fpga/{ => xilinx}/xilinx-spi.c (100%)
>>   rename drivers/fpga/{ => xilinx}/zynq-fpga.c (100%)
>>   rename drivers/fpga/{ => xilinx}/zynqmp-fpga.c (100%)
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 7a290b2234576..28c261807b428 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -52,25 +52,12 @@ config FPGA_MGR_ALTERA_CVP
>>   	  FPGA manager driver support for Arria-V, Cyclone-V, Stratix-V,
>>   	  Arria 10 and Stratix10 Altera FPGAs using the CvP interface over PCIe.
>>   
>> -config FPGA_MGR_ZYNQ_FPGA
>> -	tristate "Xilinx Zynq FPGA"
>> -	depends on ARCH_ZYNQ || COMPILE_TEST
>> -	help
>> -	  FPGA manager driver support for Xilinx Zynq FPGAs.
>> -
>>   config FPGA_MGR_STRATIX10_SOC
>>   	tristate "Intel Stratix10 SoC FPGA Manager"
>>   	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
>>   	help
>>   	  FPGA manager driver support for the Intel Stratix10 SoC.
>>   
>> -config FPGA_MGR_XILINX_SPI
>> -	tristate "Xilinx Configuration over Slave Serial (SPI)"
>> -	depends on SPI
>> -	help
>> -	  FPGA manager driver support for Xilinx FPGA configuration
>> -	  over slave serial interface.
>> -
>>   config FPGA_MGR_ICE40_SPI
>>   	tristate "Lattice iCE40 SPI"
>>   	depends on OF && SPI
>> @@ -113,23 +100,6 @@ config ALTERA_FREEZE_BRIDGE
>>   	  isolate one region of the FPGA from the busses while that
>>   	  region is being reprogrammed.
>>   
>> -config XILINX_PR_DECOUPLER
>> -	tristate "Xilinx LogiCORE PR Decoupler"
>> -	depends on FPGA_BRIDGE
>> -	depends on HAS_IOMEM
>> -	help
>> -	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
>> -	  or Xilinx Dynamic Function eXchnage AIX Shutdown Manager.
>> -	  The PR Decoupler exists in the FPGA fabric to isolate one
>> -	  region of the FPGA from the busses while that region is
>> -	  being reprogrammed during partial reconfig.
>> -	  The Dynamic Function eXchange AXI shutdown manager prevents
>> -	  AXI traffic from passing through the bridge. The controller
>> -	  safely handles AXI4MM and AXI4-Lite interfaces on a
>> -	  Reconfigurable Partition when it is undergoing dynamic
>> -	  reconfiguration, preventing the system deadlock that can
>> -	  occur if AXI transactions are interrupted by DFX.
>> -
>>   config FPGA_REGION
>>   	tristate "FPGA Region"
>>   	depends on FPGA_BRIDGE
>> @@ -146,14 +116,6 @@ config OF_FPGA_REGION
>>   	  overlay.
>>   
>>   source "drivers/fpga/dfl/Kconfig"
>> -
>> -config FPGA_MGR_ZYNQMP_FPGA
>> -	tristate "Xilinx ZynqMP FPGA"
>> -	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
>> -	help
>> -	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
>> -	  This driver uses the processor configuration port(PCAP)
>> -	  to configure the programmable logic(PL) through PS
>> -	  on ZynqMP SoC.
>> +source "drivers/fpga/xilinx/Kconfig"
>>   
>>   endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index bda74e54ce390..0868c7c4264d8 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -15,9 +15,6 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
>>   obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
>>   obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
>>   obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>> -obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>> -obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>> -obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>>   obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>>   obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>   
>> @@ -25,10 +22,10 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>   obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>>   obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>>   obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
>> -obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
>>   
>>   # High Level Interfaces
>>   obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
>>   obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
>>   
>>   obj-$(CONFIG_FPGA_DFL) += dfl/
>> +obj-$(CONFIG_FPGA_XILINX) += xilinx/
>> diff --git a/drivers/fpga/xilinx/Kconfig b/drivers/fpga/xilinx/Kconfig
>> new file mode 100644
>> index 0000000000000..e016d450539a0
>> --- /dev/null
>> +++ b/drivers/fpga/xilinx/Kconfig
>> @@ -0,0 +1,55 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config FPGA_XILINX
>> +	bool "Xilinx FPGAs"
> "Xilinx FPGA drivers"
>
>> +	default y
>> +	help
>> +	  If you have a xilinx fpga, say Y.
> "Xilix FPGA"
Ok.
> But how about being a bit more descriptive here:
>
> "Select this option if you want to enable support for Xilinx FPGA
> drivers"
ok
>
>> +	  Note that the answer to this question doesn't directly affect the
>> +	  kernel: saying N will just cause the configurator to skip all
>> +	  the questions about xilinx fpgas. If you say Y, you will be asked
>> +	  for your specific device in the following questions.
> Why this "note"?  Do networking drivers have this type of description?

Yes, the NET_VENDOR_* configs all have this boilerplate.

Tom

> Same for the other patches in this series.
> thanks,
>
> greg k-h
>

