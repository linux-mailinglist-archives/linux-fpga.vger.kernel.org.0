Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211903018EE
	for <lists+linux-fpga@lfdr.de>; Sun, 24 Jan 2021 00:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAWXfv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 23 Jan 2021 18:35:51 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:52758 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbhAWXft (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 23 Jan 2021 18:35:49 -0500
Received: by mail-pj1-f52.google.com with SMTP id kx7so6097928pjb.2;
        Sat, 23 Jan 2021 15:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y8zqB2yoEzEnz4ItpJSnoy0J2SARkRZOXZyw/BOuwJ4=;
        b=jwUhQdyt827r6BWcQjoPRD3+RAc9Cik7gABIIM00zwwraDM6fcqx6gijnKs0BVHIhI
         7MPXAe0p3NW8zj+YObfhBvB5l0GCS2bFbcwbyQyODsUBcTB3agse1icScQIQm0V9EE8/
         g6Rr/YCgiecrFBqYUhAGJJkgEj5oO9bgjRBpNKNyQ+pwbyAva3P9X54VAmpnxTVRtCFb
         mIFsziCR9B2IuabSdkmQYH2tHESfmThGviLLrzWnQ+Gd5xRq8bzxSqHIhnMGCNrQUk05
         HRuhXvnZJXdZ1VOiyFXg/x3oDaDG1zX9k3bSKYTbRQhUjJuZ/wzngicqX18UgVK1y4fU
         Nb9Q==
X-Gm-Message-State: AOAM531LTAd4ySiNIwLvdSh9GuAFgbIToKPNGQgcrYscIXZodU6zYJVz
        q73oy6C6fj6rhi/IcEAtWPDc3Vd5Dy8=
X-Google-Smtp-Source: ABdhPJz5Sy+oQHLjDwYPnabWkahWhvdFu/1JHZungRkDeU02nO0Ao7JXynLf5zWnRPTRQY+7uO5bdg==
X-Received: by 2002:a17:90a:245:: with SMTP id t5mr13927912pje.89.1611444908682;
        Sat, 23 Jan 2021 15:35:08 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id p13sm13288095pju.20.2021.01.23.15.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 15:35:07 -0800 (PST)
Date:   Sat, 23 Jan 2021 15:35:06 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, trix@redhat.com, robh+dt@kernel.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com
Subject: Re: [PATCH 1/3] drivers: firmware: Add Pdi load API support
Message-ID: <YAyyqnCmYcWGgbom@epycbox.lan>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118024318.9530-1-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 18, 2021 at 08:13:16AM +0530, Nava kishore Manne wrote:
> This patch adds load pdi api support to enable pdi/partial loading from
> linux. Programmable Device Image (PDI) is combination of headers, images
> and bitstream files to be loaded. Partial PDI is partial set of image/
> images to be loaded.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |  9 +++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 7eb9958662dd..a466225b9f9e 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -897,6 +897,23 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
>  
> +/**
> + * zynqmp_pm_load_pdi - Load and process pdi
Nit: Is it pdi or PDI. Pick one :)
> + * @src:       Source device where PDI is located
> + * @address:   Pdi src address
> + *
> + * This function provides support to load pdi from linux
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +int zynqmp_pm_load_pdi(const u32 src, const u64 address)
> +{
> +	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, src,
> +				   lower_32_bits(address),
> +				   upper_32_bits(address), 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_load_pdi);
> +
>  /**
>   * zynqmp_pm_aes - Access AES hardware to encrypt/decrypt the data using
>   * AES-GCM core.
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 2a0da841c942..87114ee645b1 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -52,6 +52,9 @@
>  #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
>  #define	ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
>  
> +/* Loader commands */
> +#define PM_LOAD_PDI	0x701
> +
>  /*
>   * Firmware FPGA Manager flags
>   * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
> @@ -354,6 +357,7 @@ int zynqmp_pm_write_pggs(u32 index, u32 value);
>  int zynqmp_pm_read_pggs(u32 index, u32 *value);
>  int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
>  int zynqmp_pm_set_boot_health_status(u32 value);
> +int zynqmp_pm_load_pdi(const u32 src, const u64 address);
>  #else
>  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
>  {
> @@ -538,6 +542,11 @@ static inline int zynqmp_pm_set_boot_health_status(u32 value)
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* __FIRMWARE_ZYNQMP_H__ */
> -- 
> 2.18.0
> 
