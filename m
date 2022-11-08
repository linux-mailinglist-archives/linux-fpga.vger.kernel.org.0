Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55432621A07
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 18:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiKHRFi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 12:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiKHRFh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 12:05:37 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2101B9EA;
        Tue,  8 Nov 2022 09:05:36 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id n205so5075888oib.1;
        Tue, 08 Nov 2022 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFWHQ9do5Ou++AGb/m0uIF38JPrYpPlx1X3G+nLfsvw=;
        b=kcpkVgbLSBs45Z8NZY0wHFgARBUY2cLM+Ys9W4hzGn+XTW5nSqKjAmRGDuFu+d3Aqg
         QKrzcjddgq/54B2pD6rwrcFVdlzzkxqevtWBWXXryw+moQGbKtlgzHtxLqUGeRs62R28
         /WIcLXXcON2vzFYUUEfOWJWyWJgTdko8K4Q9MmPZ9UWpULItHeZtU8AcQoCeNc2V/LDC
         RhXnvA1KcaHAkztaP0ERDlJiqlpt5A7D1z0AyuV3KOf+NgmBAPYsAqt12EqpI363THHA
         HztTr4Hk0eBQ7EAkChThufUqMjh4fRF4WjrKHUuUXlD6BM7zmlIxy/LjH5C2M2FJxFB6
         vMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFWHQ9do5Ou++AGb/m0uIF38JPrYpPlx1X3G+nLfsvw=;
        b=C1S+ALG/SI+EsgKFI/oSWB77NV/GszQvSZgo1ZO//oj4mwi2IWWX1YQ4ja/9Ei+FrQ
         3VOJ3Yk/G6QpDBo3eXr/yXXhG64s1844O8i61gvPxbAjJF5kLW3IBC8enyBEGtJp6PC+
         FEp93SK/v9bT5BNwrfwrgbOy0Iqa40tN9ZEvXLOccZ6vmtYXQttipNA1lfmX6ZBIsAhO
         mkQFo8i4kNXD1/H/XpOHrH/20cKLMCUWY95c9dRcDoabWwqbr0rRU6JrCTexdgqCJphF
         5QAl2g3urriavpl8694y4576QxIVRS1K7cr5G0+M5frIgvqfWbANFgWrOdYf+oy4kIIH
         iyFQ==
X-Gm-Message-State: ACrzQf1FCjo1VO7BVme+I2lDGYeNwS6YtcFAsKwyzHGS52VbK6J2je0o
        IYTLOn4xOq+g0D3o5ghXYZydWCcqquY=
X-Google-Smtp-Source: AMsMyM7QUL0uSPAOZjBzhFsflsHeBn+sVmTFyhA2/ReEtOb39v8XcxV4MBOhVwEgmE/qgA8NmVbryw==
X-Received: by 2002:a05:6808:194:b0:359:e535:bed2 with SMTP id w20-20020a056808019400b00359e535bed2mr30576490oic.124.1667927135962;
        Tue, 08 Nov 2022 09:05:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h24-20020a9d6418000000b0066193df8edasm4233846otl.34.2022.11.08.09.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:05:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 8 Nov 2022 09:05:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 04/12] mfd: intel-m10-bmc: Split into core and spi
 specific parts
Message-ID: <20221108170534.GB801591@roeck-us.net>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221108144305.45424-5-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 08, 2022 at 04:42:57PM +0200, Ilpo Järvinen wrote:
> Split the common code from intel-m10-bmc driver into intel-m10-bmc-core
> and move the SPI bus parts into an interface specific file.
> 
> intel-m10-bmc-core becomes the core MFD functions which can support
> multiple bus interface like SPI bus.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  MAINTAINERS                                   |   2 +-
>  drivers/fpga/Kconfig                          |   2 +-
>  drivers/hwmon/Kconfig                         |   2 +-
>  drivers/mfd/Kconfig                           |  30 ++--
>  drivers/mfd/Makefile                          |   5 +-
>  drivers/mfd/intel-m10-bmc-core.c              | 122 +++++++++++++++++
>  .../{intel-m10-bmc.c => intel-m10-bmc-spi.c}  | 128 +++---------------
>  include/linux/mfd/intel-m10-bmc.h             |   6 +
>  8 files changed, 173 insertions(+), 124 deletions(-)
>  create mode 100644 drivers/mfd/intel-m10-bmc-core.c
>  rename drivers/mfd/{intel-m10-bmc.c => intel-m10-bmc-spi.c} (60%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..ddfa4f8b3c80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10452,7 +10452,7 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>  F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
>  F:	drivers/hwmon/intel-m10-bmc-hwmon.c
> -F:	drivers/mfd/intel-m10-bmc.c
> +F:	drivers/mfd/intel-m10-bmc*
>  F:	include/linux/mfd/intel-m10-bmc.h
>  
>  INTEL MENLOW THERMAL DRIVER
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index d1a8107fdcb3..e4daf79943ee 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -246,7 +246,7 @@ config FPGA_MGR_VERSAL_FPGA
>  
>  config FPGA_M10_BMC_SEC_UPDATE
>  	tristate "Intel MAX10 BMC Secure Update driver"
> -	depends on MFD_INTEL_M10_BMC && FW_UPLOAD
> +	depends on MFD_INTEL_M10_BMC_CORE && FW_UPLOAD
>  	help
>  	  Secure update support for the Intel MAX10 board management
>  	  controller.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 7ac3daaf59ce..984a55e0f313 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2321,7 +2321,7 @@ config SENSORS_XGENE
>  
>  config SENSORS_INTEL_M10_BMC_HWMON
>  	tristate "Intel MAX10 BMC Hardware Monitoring"
> -	depends on MFD_INTEL_M10_BMC
> +	depends on MFD_INTEL_M10_BMC_CORE

In my opinion the change from MFD_INTEL_M10_BMC to MFD_INTEL_M10_BMC_CORE
(and thus the need to touch lots of Kconfig files) is not really necessary.

Not worth bike shedding about, though, so for hwmon

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter
