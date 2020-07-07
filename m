Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF81216573
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jul 2020 06:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgGGEkB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Jul 2020 00:40:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41002 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGGEkB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Jul 2020 00:40:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id g67so18521436pgc.8;
        Mon, 06 Jul 2020 21:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V3n6WROzLwJxYsLZgGzIdM4tIj8ploaCm42uSLfvIPg=;
        b=EZbe6Dkk5UdT7MFNeXfD58ixEfboiAWLBQKdKwCemiy6mjG372Z8dOc0xSX/6K9EEJ
         BOpE05PCW4Nu1TZ5pXLvlZ+xsRSb5zvoPdifbO66TPspSzKQtqS9V25MPcG3K/VaFyaq
         9NVFBc+/hWz71q8w1MF52FaphJU4Mhxkv/VJuXamnFRcgM6SkKzRUxP0XIUCaTOV+yhR
         7beoMzeDjpY6sjPqS6+e55yZMrYUFY1kTrCSDPuG7S4U9Zwh8tmstfyRKgS3e1KrjK7Y
         4ZW956mOM6sT5eq+2MHFopbFO98wW81lhNil5iw5juUD7T387UhzrsPHiXKeoNDTUkqG
         JzsQ==
X-Gm-Message-State: AOAM531XqoqxfZXyRTD+Agn1C9YU/5oBV5OIFz1jK9Z0v9ODXbtd7UKc
        3IAPP46HygJ8thkFMb1rfq0=
X-Google-Smtp-Source: ABdhPJzdcwoccYuU4CCMTnzjieuZGpMebZdvVd+R/ax4Ch+e/tzbctX0NdrNfSedEp5NlEWVmPDKTQ==
X-Received: by 2002:a05:6a00:5c:: with SMTP id i28mr30797667pfk.274.1594096800473;
        Mon, 06 Jul 2020 21:40:00 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id s89sm956822pjj.28.2020.07.06.21.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 21:40:00 -0700 (PDT)
Date:   Mon, 6 Jul 2020 21:39:59 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        mtosatti@redhat.com, gregkh@linuxfoundation.org,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v7 6/7] fpga: dfl: afu: add AFU interrupt support
Message-ID: <20200707043959.GC10464@epycbox.lan>
References: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
 <1592280528-6350-7-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592280528-6350-7-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 16, 2020 at 12:08:47PM +0800, Xu Yilun wrote:
> AFU (Accelerated Function Unit) is dynamic region of the DFL based FPGA,
> and always defined by users. Some DFL based FPGA cards allow users to
> implement their own interrupts in AFU. In order to support this,
> hardware implements a new UINT (AFU Interrupt) private feature with
> related capability register which describes the number of supported
> AFU interrupts as well as the local index of the interrupts for
> software enumeration, and from software side, driver follows the common
> DFL interrupt notification and handling mechanism, and it implements
> two ioctls below for user to query number of irqs supported and set/unset
> interrupt triggers.
> 
>  Ioctls:
>  * DFL_FPGA_PORT_UINT_GET_IRQ_NUM
>    get the number of irqs, which is used to determine how many interrupts
>    UINT feature supports.
> 
>  * DFL_FPGA_PORT_UINT_SET_IRQ
>    set/unset eventfds as AFU interrupt triggers.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: use DFL_FPGA_PORT_UINT_GET_IRQ_NUM instead of
>     DFL_FPGA_PORT_UINT_GET_INFO
>     Delete flags field for DFL_FPGA_PORT_UINT_SET_IRQ
> v3: put_user() instead of copy_to_user()
>     improves comments
> v4: use common functions to handle irq ioctls
> v5: Minor fixes for Hao's comments
> v6: No change
> v7: No change
> ---
>  drivers/fpga/dfl-afu-main.c   | 28 ++++++++++++++++++++++++++++
>  include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 357cd5d..7c84fee 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -529,6 +529,30 @@ static const struct dfl_feature_ops port_stp_ops = {
>  	.init = port_stp_init,
>  };
>  
> +static long
> +port_uint_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case DFL_FPGA_PORT_UINT_GET_IRQ_NUM:
> +		return dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
> +	case DFL_FPGA_PORT_UINT_SET_IRQ:
> +		return dfl_feature_ioctl_set_irq(pdev, feature, arg);
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +		return -ENODEV;
> +	}
> +}
> +
> +static const struct dfl_feature_id port_uint_id_table[] = {
> +	{.id = PORT_FEATURE_ID_UINT,},
> +	{0,}
> +};
> +
> +static const struct dfl_feature_ops port_uint_ops = {
> +	.ioctl = port_uint_ioctl,
> +};
> +
>  static struct dfl_feature_driver port_feature_drvs[] = {
>  	{
>  		.id_table = port_hdr_id_table,
> @@ -547,6 +571,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
>  		.ops = &port_stp_ops,
>  	},
>  	{
> +		.id_table = port_uint_id_table,
> +		.ops = &port_uint_ops,
> +	},
> +	{
>  		.ops = NULL,
>  	}
>  };
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index b6495ea..1621b07 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -187,6 +187,29 @@ struct dfl_fpga_irq_set {
>  					     DFL_PORT_BASE + 6,	\
>  					     struct dfl_fpga_irq_set)
>  
> +/**
> + * DFL_FPGA_PORT_UINT_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 7,
> + *								__u32 num_irqs)
> + *
> + * Get the number of irqs supported by the fpga AFU interrupt private
> + * feature.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_UINT_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 7, __u32)
> +
> +/**
> + * DFL_FPGA_PORT_UINT_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 8,
> + *						struct dfl_fpga_irq_set)
> + *
> + * Set fpga AFU interrupt trigger if evtfds[n] is valid.
> + * Unset related interrupt trigger if evtfds[n] is a negative value.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_UINT_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 8,	\
> +					     struct dfl_fpga_irq_set)
> +
>  /* IOCTLs for FME file descriptor */
>  
>  /**
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks!
