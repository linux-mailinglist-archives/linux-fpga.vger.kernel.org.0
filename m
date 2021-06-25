Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440323B4939
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhFYT3L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 15:29:11 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:42635 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYT3L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 25 Jun 2021 15:29:11 -0400
Received: by mail-pg1-f181.google.com with SMTP id d12so8770845pgd.9;
        Fri, 25 Jun 2021 12:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h1GdoT+CpTe+GaIuEBpH8gMshMEuLSCbkgQ3nh1A9HQ=;
        b=jjzJSgpcpLZRT2zsaBKgw8AOLGnmAKDA1G/SyEEPDcwxbAM8NUjjtSnmGMoO/9cqFs
         7lnGBeXKN8xPAQVgj/zrcZ7XldqU3hmRbEp8gUQ9T+EPmwsjraNEHjRAzeu69b3KfxNl
         hpQcjyIEKDO0NFI4+DSc9iCk0hkqpoqyWz+GFSJaVytZAbslrFzDPAJED7fCfKDOlAjJ
         HDaHGmZbwk626LMccW0xiIxb7nTp/CS9678K8rlmaQWMwlBrah7qEq+6lIlg0x7vu7pM
         YsgavzRcCIcyqga+Qzge8qh1hsyMPKd+Ep1qibUz231lqSR5uYtyaRCrpyiAalGSI0qw
         trhQ==
X-Gm-Message-State: AOAM533gZvITPeDkOkmmjczH9k/+pYmwaziwog2O0wD+GR14gtku4nFW
        FD9vAKaPMSUf+FXYWeAbJSo=
X-Google-Smtp-Source: ABdhPJwTEEzENLi2KqgrCM7qoAwDS8vgHBE3F82EOEjnj7s+DoBBdlOy15DkQ0bU5Jj9FxbxmBMcAw==
X-Received: by 2002:a63:e958:: with SMTP id q24mr10982182pgj.438.1624649210126;
        Fri, 25 Jun 2021 12:26:50 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id a15sm6507385pff.128.2021.06.25.12.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:26:49 -0700 (PDT)
Date:   Fri, 25 Jun 2021 12:26:48 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/5] fpga: dfl: expose feature revision from struct
 dfl_device
Message-ID: <YNYt+Dl43zhkjIhI@epycbox.lan>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-3-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625074213.654274-3-martin@geanix.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 25, 2021 at 09:42:10AM +0200, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
> 
> Drivers can make use of the feature field from the DFL header, but
> shouldn't know about the header structure. To avoid exposing such info,
> and to reduce the number of reads from the io-mem, the revision is added
> to struct dfl_device.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> ---
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
> index 511b20ff35a3..9381c579d1cd 100644
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
> +	u8 rev;
>  	struct resource mmio_res;
>  	void __iomem *ioaddr;
>  	struct list_head node;
> @@ -796,6 +798,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  		/* save resource information for each feature */
>  		feature->dev = fdev;
>  		feature->id = finfo->fid;
> +		feature->revision = finfo->rev;
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
> +	u8 rev;
> +	u64 v;
> +
> +	v = readq(binfo->ioaddr + ofst);
> +	rev = FIELD_GET(DFH_REVISION, v);
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
> +	finfo->rev = rev;
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
Looks good to me, any concerns from Intel folks?

- Moritz
