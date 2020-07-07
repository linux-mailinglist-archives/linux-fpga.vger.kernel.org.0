Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60276216571
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jul 2020 06:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGGEjn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Jul 2020 00:39:43 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36218 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGGEjn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Jul 2020 00:39:43 -0400
Received: by mail-il1-f196.google.com with SMTP id x9so34901261ila.3;
        Mon, 06 Jul 2020 21:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u1k0WXLh4VpmPZzwJmAXxNdNF3S5Ky4LS7LkM/IeB1s=;
        b=A07s5quITkkAa94EX6/jrMqbmZLWhywYTbOuRZfEj+e4yvykcjLdGXIYBhcRkB0Qfu
         mE3Svre5JiPb4YhrIHbQ20gHxD3IWQh8DV/JdoTSGYdXGJAnxq0UaBxU5aGuq5TqIzfu
         osdXe5BtDycTaawqEzi1ocvu6y743NSQRrNnQeFNCItVvlht9DhU23rsZxxIBWitFkkR
         szkAS6Iq278ybbxUYszK0rThOF0/GydZfNdjPzXI+SnzpnCFkBeOgvLjy0HGc+LvDIRS
         +IlyT6eo8Ke+qv4O1+Gnd/oPGJdFY1tF41HRGNKUkMDFLywuW+cwlDLa/l6d+rTZciN8
         Kfjw==
X-Gm-Message-State: AOAM532uN5Yankv3TtTApYXDYupHDLdfcR/MQ/k8Otzt/ZKxASu6qT6h
        vn5FvQvxVA8IZUnfbnHyjSI94ODlBGw=
X-Google-Smtp-Source: ABdhPJy8j7pJu2rAisQntxuudjDWp5hU4alKvZSVjEzsOXt9MsqXgZwc88K0TzhTyqNNKVi7SVtVSA==
X-Received: by 2002:a92:9a17:: with SMTP id t23mr35522108ili.105.1594096782063;
        Mon, 06 Jul 2020 21:39:42 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 13sm12500357ilj.81.2020.07.06.21.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 21:39:41 -0700 (PDT)
Date:   Mon, 6 Jul 2020 21:39:40 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        mtosatti@redhat.com, gregkh@linuxfoundation.org,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v7 5/7] fpga: dfl: fme: add interrupt support for global
 error reporting
Message-ID: <20200707043940.GB10464@epycbox.lan>
References: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
 <1592280528-6350-6-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592280528-6350-6-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 16, 2020 at 12:08:46PM +0800, Xu Yilun wrote:
> Error reporting interrupt is very useful to notify users that some
> errors are detected by the hardware. Once users are notified, they
> could query hardware logged error states, no need to continuously
> poll on these states.
> 
> This patch adds interrupt support for fme global error reporting sub
> feature. It follows the common DFL interrupt notification and handling
> mechanism. And it implements two ioctls below for user to query
> number of irqs supported, and set/unset interrupt triggers.
> 
>  Ioctls:
>  * DFL_FPGA_FME_ERR_GET_IRQ_NUM
>    get the number of irqs, which is used to determine whether/how many
>    interrupts fme error reporting feature supports.
> 
>  * DFL_FPGA_FME_ERR_SET_IRQ
>    set/unset given eventfds as fme error reporting interrupt triggers.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: use DFL_FPGA_FME_ERR_GET_IRQ_NUM instead of
>     DFL_FPGA_FME_ERR_GET_INFO
>     Delete flags field for DFL_FPGA_FME_ERR_SET_IRQ
> v3: put_user() instead of copy_to_user()
>     improves comments
> v4: use common functions to handle irq ioctls
> v5: Minor fixes for Hao's comments
> v6: No change
> v7: No change
> ---
>  drivers/fpga/dfl-fme-error.c  | 18 ++++++++++++++++++
>  drivers/fpga/dfl-fme-main.c   |  6 ++++++
>  include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
> index f897d41..51c2892 100644
> --- a/drivers/fpga/dfl-fme-error.c
> +++ b/drivers/fpga/dfl-fme-error.c
> @@ -15,6 +15,7 @@
>   *   Mitchel, Henry <henry.mitchel@intel.com>
>   */
>  
> +#include <linux/fpga-dfl.h>
>  #include <linux/uaccess.h>
>  
>  #include "dfl.h"
> @@ -348,6 +349,22 @@ static void fme_global_err_uinit(struct platform_device *pdev,
>  	fme_err_mask(&pdev->dev, true);
>  }
>  
> +static long
> +fme_global_error_ioctl(struct platform_device *pdev,
> +		       struct dfl_feature *feature,
> +		       unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case DFL_FPGA_FME_ERR_GET_IRQ_NUM:
> +		return dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
> +	case DFL_FPGA_FME_ERR_SET_IRQ:
> +		return dfl_feature_ioctl_set_irq(pdev, feature, arg);
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +		return -ENODEV;
> +	}
> +}
> +
>  const struct dfl_feature_id fme_global_err_id_table[] = {
>  	{.id = FME_FEATURE_ID_GLOBAL_ERR,},
>  	{0,}
> @@ -356,4 +373,5 @@ const struct dfl_feature_id fme_global_err_id_table[] = {
>  const struct dfl_feature_ops fme_global_err_ops = {
>  	.init = fme_global_err_init,
>  	.uinit = fme_global_err_uinit,
> +	.ioctl = fme_global_error_ioctl,
>  };
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index fc210d4..77ea04d 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -620,11 +620,17 @@ static int fme_release(struct inode *inode, struct file *filp)
>  {
>  	struct dfl_feature_platform_data *pdata = filp->private_data;
>  	struct platform_device *pdev = pdata->dev;
> +	struct dfl_feature *feature;
>  
>  	dev_dbg(&pdev->dev, "Device File Release\n");
>  
>  	mutex_lock(&pdata->lock);
>  	dfl_feature_dev_use_end(pdata);
> +
> +	if (!dfl_feature_dev_use_count(pdata))
> +		dfl_fpga_dev_for_each_feature(pdata, feature)
> +			dfl_fpga_set_irq_triggers(feature, 0,
> +						  feature->nr_irqs, NULL);
>  	mutex_unlock(&pdata->lock);
>  
>  	return 0;
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index 6c71c9d..b6495ea 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -230,4 +230,27 @@ struct dfl_fpga_fme_port_pr {
>   */
>  #define DFL_FPGA_FME_PORT_ASSIGN     _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 2, int)
>  
> +/**
> + * DFL_FPGA_FME_ERR_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_FME_BASE + 3,
> + *							__u32 num_irqs)
> + *
> + * Get the number of irqs supported by the fpga fme error reporting private
> + * feature. Currently hardware supports up to 1 irq.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_FME_ERR_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
> +					     DFL_FME_BASE + 3, __u32)
> +
> +/**
> + * DFL_FPGA_FME_ERR_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 4,
> + *						struct dfl_fpga_irq_set)
> + *
> + * Set fpga fme error reporting interrupt trigger if evtfds[n] is valid.
> + * Unset related interrupt trigger if evtfds[n] is a negative value.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_FME_ERR_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
> +					     DFL_FME_BASE + 4,	\
> +					     struct dfl_fpga_irq_set)
> +
>  #endif /* _UAPI_LINUX_FPGA_DFL_H */
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks!
