Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A552F905C
	for <lists+linux-fpga@lfdr.de>; Sun, 17 Jan 2021 04:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbhAQD6b (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Jan 2021 22:58:31 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:38991 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbhAQD6a (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Jan 2021 22:58:30 -0500
Received: by mail-pf1-f177.google.com with SMTP id m6so8127282pfm.6;
        Sat, 16 Jan 2021 19:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyh7gDLlSAQV6EbKAPmjVdfsXREpXfZ7PZWPtjqkTl0=;
        b=aCPq6OSE4XdcoT9lENZbHC8vXkbpgoNW6T9A+/zuVXN5T2NJ6h17Du8sxZyLWtJStW
         g8x7mE1OxE9wH76RnZXG59Dn6Qx8lWTdKrNsMDT1D290HcXvK+S1afAw6ksZx9kVydvN
         Gvxs6qPC8uKpDMZxQQs6ywhYTn2/Ay+aKJVsx/GHYkD+DZaEtIf/TKPSOIEeQPnlIySY
         4o8s+c+mk9gdPVUGkE6egD0BzPvXh19ZLah5JiHUekBMkAxyZSAOIgMujj8YDLSmni8Y
         esfnKIwLAJgdT6MA3eMWZ5qlzhGu2Vn9l6dCLl+9jCPt9qVXG7/X5aVo7V0Fj7ZdTVE3
         g1LA==
X-Gm-Message-State: AOAM532X81ly2COSk6CCIN+U+l+OurVsuEBIJTf50NnN7IPR+PGMYNYX
        YEgwAeeldx6WLEyv3nIum5UxBS1PXyY=
X-Google-Smtp-Source: ABdhPJwvwro6/YR8+IYunHszon9kb3nUTvQ7rCwSopR5d/bai6FRKbjYuuxmjasKM6nbI1aQUqsJfQ==
X-Received: by 2002:a63:f111:: with SMTP id f17mr20632863pgi.287.1610855869933;
        Sat, 16 Jan 2021 19:57:49 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id m26sm11760823pfo.123.2021.01.16.19.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 19:57:49 -0800 (PST)
Date:   Sat, 16 Jan 2021 19:57:48 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v6 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
Message-ID: <YAO1vA6DWxTdjBOz@epycbox.lan>
References: <1610502848-30345-1-git-send-email-yilun.xu@intel.com>
 <1610502848-30345-3-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610502848-30345-3-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Xu,

On Wed, Jan 13, 2021 at 09:54:08AM +0800, Xu Yilun wrote:
> This patch adds description for UIO support for dfl devices on DFL
> bus.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: no doc in v1, add it for v2.
> v3: some documentation fixes.
> v4: documentation change since the driver matching is changed.
> v5: no change.
> v6: improve the title of the userspace driver support section.
>     some word improvement.
> ---
>  Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 0404fe6..c33b6d0 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -7,6 +7,7 @@ Authors:
>  - Enno Luebbers <enno.luebbers@intel.com>
>  - Xiao Guangrong <guangrong.xiao@linux.intel.com>
>  - Wu Hao <hao.wu@intel.com>
> +- Xu Yilun <yilun.xu@intel.com>
>  
>  The Device Feature List (DFL) FPGA framework (and drivers according to
>  this framework) hides the very details of low layer hardwares and provides
> @@ -502,6 +503,29 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
>  
> +Userspace driver support for DFL devices
> +========================================
> +The purpose of an FPGA is to be reprogrammed with newly developed hardware
> +components. New hardware can instantiate a new private feature in the DFL, and
> +then get a DFL device in their system. In some cases users may need a userspace
> +driver for the DFL device:
> +
> +* Users may need to run some diagnostic test for their hardwares.
> +* Users may prototype the kernel driver in user space.
> +* Some hardware is designed for specific purposes and does not fit into one of
> +  the standard kernel subsystems.
> +
> +This requires direct access to MMIO space and interrupt handling from
> +userspace. The dfl-uio-pdev module exposes the UIO device interfaces for this
> +purpose. It adds the uio_pdrv_genirq platform device with the resources of
> +the DFL feature, and lets the generic UIO platform device driver provide UIO
> +support to userspace.
> +
> +FPGA_DFL_UIO_PDEV should be selected to enable the dfl-uio-pdev module driver.
> +To support a new DFL feature been directly accessed via UIO, its feature id
> +should be added to the driver's id_table.
> +
> +
>  Open discussion
>  ===============
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
> -- 
> 2.7.4
> 

Looks fine to me, can you resend with changes for the other patch?

- Moritz
