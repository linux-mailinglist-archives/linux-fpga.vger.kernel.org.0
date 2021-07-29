Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6277C3DAC5F
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Jul 2021 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhG2UEy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Jul 2021 16:04:54 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:47084 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhG2UEx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Jul 2021 16:04:53 -0400
Received: by mail-pl1-f182.google.com with SMTP id t21so8227792plr.13;
        Thu, 29 Jul 2021 13:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IHRkpF0RO7xgumloMSUZy6/MlTJAsHxlyDJXP+2mTd8=;
        b=i6/kWaaxwh43qFB8sYwDyFJDsZOE7ZfAWxc85m6TXbKwAdSUx6jIe4VuQH3deeufNQ
         yjj81odVw9HHSnFk9Ge434sa8ouG5jTYja6i5Pt4PeOoCii9sK45+72PIivDFHZemxu3
         K7R3GR6pazMqmlAe+3eciuE6ARhwWV1I/ZlivCmJrBb6rI4Bx5jocp7fBwZPCBZyQz1B
         XtIm0lheE3v0X50B8A8IQCONuL8XaZ9GNMlvuHWcbJC/tJTuGceILIqvndsLHyK2eXNi
         MIyYawv2uGn5gKT7yBD8PSZgM+Yt7U5X4LOahgF17KLGfn6pIMk+lmtxGTCxJFtm6iVm
         J7AA==
X-Gm-Message-State: AOAM532eKrp4DAICEdKPYGC1tF7OJ/2iljOEblY2r7XUYm3ndgjc7epI
        B61HC3dDvve+9wWc5ZFgrTQ=
X-Google-Smtp-Source: ABdhPJxwBLkt8B/tY+5WYrqCRbM2Hr03x84qARqvRTVM5uIeBGiOklXkkP/i8FmNwFJl9YBZruitkw==
X-Received: by 2002:a17:90a:990f:: with SMTP id b15mr16514780pjp.188.1627589088651;
        Thu, 29 Jul 2021 13:04:48 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id q17sm5440135pgd.39.2021.07.29.13.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:04:47 -0700 (PDT)
Date:   Thu, 29 Jul 2021 13:04:46 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v5 1/3] fpga: dfl: expose feature revision from struct
 dfl_device
Message-ID: <YQMJ3tG9jlYNK+dx@epycbox.lan>
References: <20210716135441.3235863-1-martin@geanix.com>
 <20210716135441.3235863-2-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210716135441.3235863-2-martin@geanix.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 16, 2021 at 03:54:39PM +0200, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
> 
> DFL device drivers have a common need for checking feature revision
> information from the DFL header, as well as other common DFL information
> like the already exposed feature id and type.
> 
> This patch exposes the feature revision information directly via the DFL
> device data structure.
> 
> Since the DFL core code has already read the DFL header, this this patch
> saves additional mmio reads from DFL device drivers too.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Acked-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> 
> Changes since v4:
>  * Renamed 'rev' to 'revision' as per Tom's suggestion
> 
> Changes since v3:
>  * Added Hao's Acked-by
>  * Added Matthew's Acked-by
> 
> Changes since v2:
>  * Reworded commit message as per Hao's suggestion
> 
> Changes since v1:
>  * This patch replaces the previous patch 2 and exposes the feature
>    revision through struct dfl_device instead of a helper reading from
>    io-mem
> 
>  drivers/fpga/dfl.c  | 27 +++++++++++++++++----------
>  drivers/fpga/dfl.h  |  1 +
>  include/linux/dfl.h |  1 +
>  3 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 511b20ff35a3..e73a70053906 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -381,6 +381,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
>  
>  	ddev->type = feature_dev_id_type(pdev);
>  	ddev->feature_id = feature->id;
> +	ddev->revision = feature->revision;
>  	ddev->cdev = pdata->dfl_cdev;
>  
>  	/* add mmio resource */
> @@ -717,6 +718,7 @@ struct build_feature_devs_info {
>   */
>  struct dfl_feature_info {
>  	u16 fid;
> +	u8 revision;
>  	struct resource mmio_res;
>  	void __iomem *ioaddr;
>  	struct list_head node;
> @@ -796,6 +798,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  		/* save resource information for each feature */
>  		feature->dev = fdev;
>  		feature->id = finfo->fid;
> +		feature->revision = finfo->revision;
>  
>  		/*
>  		 * the FIU header feature has some fundamental functions (sriov
> @@ -910,19 +913,17 @@ static void build_info_free(struct build_feature_devs_info *binfo)
>  	devm_kfree(binfo->dev, binfo);
>  }
>  
> -static inline u32 feature_size(void __iomem *start)
> +static inline u32 feature_size(u64 value)
>  {
> -	u64 v = readq(start + DFH);
> -	u32 ofst = FIELD_GET(DFH_NEXT_HDR_OFST, v);
> +	u32 ofst = FIELD_GET(DFH_NEXT_HDR_OFST, value);
>  	/* workaround for private features with invalid size, use 4K instead */
>  	return ofst ? ofst : 4096;
>  }
>  
> -static u16 feature_id(void __iomem *start)
> +static u16 feature_id(u64 value)
>  {
> -	u64 v = readq(start + DFH);
> -	u16 id = FIELD_GET(DFH_ID, v);
> -	u8 type = FIELD_GET(DFH_TYPE, v);
> +	u16 id = FIELD_GET(DFH_ID, value);
> +	u8 type = FIELD_GET(DFH_TYPE, value);
>  
>  	if (type == DFH_TYPE_FIU)
>  		return FEATURE_ID_FIU_HEADER;
> @@ -1021,10 +1022,15 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
>  	int ret;
> +	u8 revision;
> +	u64 v;
> +
> +	v = readq(binfo->ioaddr + ofst);
> +	revision = FIELD_GET(DFH_REVISION, v);
>  
>  	/* read feature size and id if inputs are invalid */
> -	size = size ? size : feature_size(binfo->ioaddr + ofst);
> -	fid = fid ? fid : feature_id(binfo->ioaddr + ofst);
> +	size = size ? size : feature_size(v);
> +	fid = fid ? fid : feature_id(v);
>  
>  	if (binfo->len - ofst < size)
>  		return -EINVAL;
> @@ -1038,6 +1044,7 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  		return -ENOMEM;
>  
>  	finfo->fid = fid;
> +	finfo->revision = revision;
>  	finfo->mmio_res.start = binfo->start + ofst;
>  	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>  	finfo->mmio_res.flags = IORESOURCE_MEM;
> @@ -1166,7 +1173,7 @@ static int parse_feature_private(struct build_feature_devs_info *binfo,
>  {
>  	if (!is_feature_dev_detected(binfo)) {
>  		dev_err(binfo->dev, "the private feature 0x%x does not belong to any AFU.\n",
> -			feature_id(binfo->ioaddr + ofst));
> +			feature_id(readq(binfo->ioaddr + ofst)));
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 2b82c96ba56c..422157cfd742 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -243,6 +243,7 @@ struct dfl_feature_irq_ctx {
>  struct dfl_feature {
>  	struct platform_device *dev;
>  	u16 id;
> +	u8 revision;
>  	int resource_index;
>  	void __iomem *ioaddr;
>  	struct dfl_feature_irq_ctx *irq_ctx;
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 6cc10982351a..431636a0dc78 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -38,6 +38,7 @@ struct dfl_device {
>  	int id;
>  	u16 type;
>  	u16 feature_id;
> +	u8 revision;
>  	struct resource mmio_res;
>  	int *irqs;
>  	unsigned int num_irqs;
> -- 
> 2.31.0
> 

Applied to for-next,

Thanks
