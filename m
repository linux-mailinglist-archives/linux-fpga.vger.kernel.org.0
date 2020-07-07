Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E733F216570
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jul 2020 06:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGGEjV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Jul 2020 00:39:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33282 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGGEjU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Jul 2020 00:39:20 -0400
Received: by mail-io1-f66.google.com with SMTP id i25so41886788iog.0;
        Mon, 06 Jul 2020 21:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NxpEwq9mbq0+9ATQbbHFMl9ZoocJtg8kDZ9e52j2Ceg=;
        b=S9pOS/pkNMBzyuBjgiGHJohseRE2DcfdFY9VKG1kC7PGNMZ6TngP3lkht0JkRbyx/9
         pT5SIhZFJzWpLG5T84T4fYxZR66jLtNGcqyaeBSMIM60N7Ui2tZ+l++BIG8vD7VywFug
         TLSnC7SoOKGNRb8nYwnzDJByxf49rIAIa5nZ/6m03GDfFjkSj4+w9TPwdRgDxQ/bEjFe
         exjqllV6NhQgsgQOCWW3h4dzbKd04v3PpacuqbJh87lKXDtdCV4wGGTEzoJ+KRztkeau
         +/9hOpKXEHd+IDyeEZmrHVO4dkUwd6WwNAMjWxDG6RluTSQlo0ODkGjk30Ruj/TqRyPY
         cnuQ==
X-Gm-Message-State: AOAM5331zj4un49iziGWX+oQxp8SIk6eg3KmROfb2n5j2pLFTnMJylZx
        fIMnKg+Oh9DsTBxHrRkMbjxOv5MP
X-Google-Smtp-Source: ABdhPJxazzQ8sC4AdFLvu9i5HWsaVnSHzABeqtGK6D1Jod+TIbFUG25PPmldkuhBcQXWgXsRDQHpuw==
X-Received: by 2002:a6b:e20b:: with SMTP id z11mr28257474ioc.2.1594096759075;
        Mon, 06 Jul 2020 21:39:19 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id q15sm12174586ilt.60.2020.07.06.21.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 21:39:18 -0700 (PDT)
Date:   Mon, 6 Jul 2020 21:39:17 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        mtosatti@redhat.com, gregkh@linuxfoundation.org,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v7 4/7] fpga: dfl: afu: add interrupt support for port
 error reporting
Message-ID: <20200707043917.GA10464@epycbox.lan>
References: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
 <1592280528-6350-5-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592280528-6350-5-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 16, 2020 at 12:08:45PM +0800, Xu Yilun wrote:
> Error reporting interrupt is very useful to notify users that some
> errors are detected by the hardware. Once users are notified, they
> could query hardware logged error states, no need to continuously
> poll on these states.
> 
> This patch adds interrupt support for port error reporting sub feature.
> It follows the common DFL interrupt notification and handling mechanism,
> implements two ioctl commands below for user to query number of irqs
> supported, and set/unset interrupt triggers.
> 
>  Ioctls:
>  * DFL_FPGA_PORT_ERR_GET_IRQ_NUM
>    get the number of irqs, which is used to determine whether/how many
>    interrupts error reporting feature supports.
> 
>  * DFL_FPGA_PORT_ERR_SET_IRQ
>    set/unset given eventfds as error interrupt triggers.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: use DFL_FPGA_PORT_ERR_GET_IRQ_NUM instead of
>     DFL_FPGA_PORT_ERR_GET_INFO
>     Delete flag field for DFL_FPGA_PORT_ERR_SET_IRQ param
> v3: put_user() instead of copy_to_user()
>     improves comments
> v4: use common functions to handle irq ioctls
> v5: minor fixes for Hao's comments
> v6: No change
> v7: No change
> ---
>  drivers/fpga/dfl-afu-error.c  | 17 +++++++++++++++++
>  drivers/fpga/dfl-afu-main.c   |  4 ++++
>  include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c1467ae..c469118 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -14,6 +14,7 @@
>   *   Mitchel Henry <henry.mitchel@intel.com>
>   */
>  
> +#include <linux/fpga-dfl.h>
>  #include <linux/uaccess.h>
>  
>  #include "dfl-afu.h"
> @@ -219,6 +220,21 @@ static void port_err_uinit(struct platform_device *pdev,
>  	afu_port_err_mask(&pdev->dev, true);
>  }
>  
> +static long
> +port_err_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
> +	       unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case DFL_FPGA_PORT_ERR_GET_IRQ_NUM:
> +		return dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
> +	case DFL_FPGA_PORT_ERR_SET_IRQ:
> +		return dfl_feature_ioctl_set_irq(pdev, feature, arg);
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +		return -ENODEV;
> +	}
> +}
> +
>  const struct dfl_feature_id port_err_id_table[] = {
>  	{.id = PORT_FEATURE_ID_ERROR,},
>  	{0,}
> @@ -227,4 +243,5 @@ const struct dfl_feature_id port_err_id_table[] = {
>  const struct dfl_feature_ops port_err_ops = {
>  	.init = port_err_init,
>  	.uinit = port_err_uinit,
> +	.ioctl = port_err_ioctl,
>  };
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index b0c3178..357cd5d 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -577,6 +577,7 @@ static int afu_release(struct inode *inode, struct file *filp)
>  {
>  	struct platform_device *pdev = filp->private_data;
>  	struct dfl_feature_platform_data *pdata;
> +	struct dfl_feature *feature;
>  
>  	dev_dbg(&pdev->dev, "Device File Release\n");
>  
> @@ -586,6 +587,9 @@ static int afu_release(struct inode *inode, struct file *filp)
>  	dfl_feature_dev_use_end(pdata);
>  
>  	if (!dfl_feature_dev_use_count(pdata)) {
> +		dfl_fpga_dev_for_each_feature(pdata, feature)
> +			dfl_fpga_set_irq_triggers(feature, 0,
> +						  feature->nr_irqs, NULL);
>  		__port_reset(pdev);
>  		afu_dma_region_destroy(pdata);
>  	}
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index 7331350..6c71c9d 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -164,6 +164,29 @@ struct dfl_fpga_irq_set {
>  	__s32 evtfds[];
>  };
>  
> +/**
> + * DFL_FPGA_PORT_ERR_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 5,
> + *								__u32 num_irqs)
> + *
> + * Get the number of irqs supported by the fpga port error reporting private
> + * feature. Currently hardware supports up to 1 irq.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_ERR_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 5, __u32)
> +
> +/**
> + * DFL_FPGA_PORT_ERR_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 6,
> + *						struct dfl_fpga_irq_set)
> + *
> + * Set fpga port error reporting interrupt trigger if evtfds[n] is valid.
> + * Unset related interrupt trigger if evtfds[n] is a negative value.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_ERR_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 6,	\
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
