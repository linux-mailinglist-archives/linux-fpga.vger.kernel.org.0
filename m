Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0308224246C
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Aug 2020 05:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgHLD4I (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Aug 2020 23:56:08 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52154 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHLD4I (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Aug 2020 23:56:08 -0400
Received: by mail-pj1-f68.google.com with SMTP id c6so464829pje.1;
        Tue, 11 Aug 2020 20:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E6UZ1+6SOLMy5k3kL5DmWKR2S8zgsO/8WL2vArsrJrU=;
        b=dxov4GlEuyaUzB4fkvXkekcBE8Od/iADlSa09Ty5EsURrLc2il3vRmklZtZFcL5MO5
         ffYqOc+GP+Ax8gUgrstw/fWRby4RLp5AQJGi+8fGpFa2HryfpRWqrxC+RV9GpSuiX+D8
         2tF94rLmxmn13wrjHfcrKfBtZRETb8gpQvRxRcGFYrCDqDM98gZM+QgCFdnzbv2TUIG9
         HWaU9b8jtZKq8l7FKCau/WUz9ayv3EtkMjuSLkkyJuquS0g88YhQnJsDfIGtd3KESbT4
         I5PXPkh0YKwUk1Z//IQ23mM6tf/0dYh7Qy90vBU/MnUByNbAoGm4z5IlpgzjpCywUnt9
         3gEA==
X-Gm-Message-State: AOAM531eZ0kUaH36wPEX5gchiLKU49ZAR3I0lTuO2jxRjN4prpmMhAkn
        k1VntA2qdSWhPHe/rR8Z1pw=
X-Google-Smtp-Source: ABdhPJy5DLzdR5AYoDamPWEPweQCCzqItmEOu4PCi2N7MUx67D8kGCGqxKiqv/KHYAfJpxS32vIWLQ==
X-Received: by 2002:a17:902:59dd:: with SMTP id d29mr3644138plj.170.1597204567004;
        Tue, 11 Aug 2020 20:56:07 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id e13sm631079pgs.13.2020.08.11.20.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 20:56:06 -0700 (PDT)
Date:   Tue, 11 Aug 2020 20:56:04 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com
Subject: Re: [PATCH v4 1/4] fpga: dfl: change data type of feature id to u16
Message-ID: <20200812035604.GA2544@epycbox.lan>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597027273-25288-2-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 10, 2020 at 10:41:10AM +0800, Xu Yilun wrote:
> The feature id is stored in a 12 bit field in DFH. So a u16 variable is
> enough for feature id.
> 
> This patch changes all feature id related places to fit u16.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v3: no change.
> v4: no change.
> ---
>  drivers/fpga/dfl-fme-perf.c |  2 +-
>  drivers/fpga/dfl.c          | 29 +++++++++++++++--------------
>  drivers/fpga/dfl.h          | 10 +++++-----
>  3 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> index 6ce1ed2..5312662 100644
> --- a/drivers/fpga/dfl-fme-perf.c
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -148,7 +148,7 @@ struct fme_perf_priv {
>  	struct device *dev;
>  	void __iomem *ioaddr;
>  	struct pmu pmu;
> -	u64 id;
> +	u16 id;
>  
>  	u32 fab_users;
>  	u32 fab_port_id;
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 649958a..18575d9 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -58,7 +58,7 @@ static const char *dfl_pdata_key_strings[DFL_ID_MAX] = {
>   */
>  struct dfl_dev_info {
>  	const char *name;
> -	u32 dfh_id;
> +	u16 dfh_id;
>  	struct idr id;
>  	enum dfl_fpga_devt_type devt_type;
>  };
> @@ -134,7 +134,7 @@ static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
>  	return DFL_ID_MAX;
>  }
>  
> -static enum dfl_id_type dfh_id_to_type(u32 id)
> +static enum dfl_id_type dfh_id_to_type(u16 id)
>  {
>  	int i;
>  
> @@ -454,7 +454,7 @@ struct build_feature_devs_info {
>   * @nr_irqs: number of irqs of this sub feature.
>   */
>  struct dfl_feature_info {
> -	u64 fid;
> +	u16 fid;
>  	struct resource mmio_res;
>  	void __iomem *ioaddr;
>  	struct list_head node;
> @@ -649,7 +649,7 @@ static inline u32 feature_size(void __iomem *start)
>  	return ofst ? ofst : 4096;
>  }
>  
> -static u64 feature_id(void __iomem *start)
> +static u16 feature_id(void __iomem *start)
>  {
>  	u64 v = readq(start + DFH);
>  	u16 id = FIELD_GET(DFH_ID, v);
> @@ -667,7 +667,7 @@ static u64 feature_id(void __iomem *start)
>  }
>  
>  static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> -			      resource_size_t ofst, u64 fid,
> +			      resource_size_t ofst, u16 fid,
>  			      unsigned int *irq_base, unsigned int *nr_irqs)
>  {
>  	void __iomem *base = binfo->ioaddr + ofst;
> @@ -713,12 +713,12 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  		return 0;
>  	}
>  
> -	dev_dbg(binfo->dev, "feature: 0x%llx, irq_base: %u, nr_irqs: %u\n",
> +	dev_dbg(binfo->dev, "feature: 0x%x, irq_base: %u, nr_irqs: %u\n",
>  		fid, ibase, inr);
>  
>  	if (ibase + inr > binfo->nr_irqs) {
>  		dev_err(binfo->dev,
> -			"Invalid interrupt number in feature 0x%llx\n", fid);
> +			"Invalid interrupt number in feature 0x%x\n", fid);
>  		return -EINVAL;
>  	}
>  
> @@ -726,7 +726,7 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  		virq = binfo->irq_table[ibase + i];
>  		if (virq < 0 || virq > NR_IRQS) {
>  			dev_err(binfo->dev,
> -				"Invalid irq table entry for feature 0x%llx\n",
> +				"Invalid irq table entry for feature 0x%x\n",
>  				fid);
>  			return -EINVAL;
>  		}
> @@ -748,7 +748,7 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  static int
>  create_feature_instance(struct build_feature_devs_info *binfo,
>  			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
> -			resource_size_t size, u64 fid)
> +			resource_size_t size, u16 fid)
>  {
>  	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
> @@ -819,9 +819,10 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>  			     struct dfl_fpga_enum_dfl *dfl,
>  			     resource_size_t ofst)
>  {
> -	u32 id, offset;
> -	u64 v;
>  	int ret = 0;
> +	u32 offset;
> +	u16 id;
> +	u64 v;
>  
>  	v = readq(dfl->ioaddr + ofst + DFH);
>  	id = FIELD_GET(DFH_ID, v);
> @@ -855,8 +856,8 @@ static int parse_feature_private(struct build_feature_devs_info *binfo,
>  				 resource_size_t ofst)
>  {
>  	if (!binfo->feature_dev) {
> -		dev_err(binfo->dev, "the private feature %llx does not belong to any AFU.\n",
> -			(unsigned long long)feature_id(dfl->ioaddr + ofst));
> +		dev_err(binfo->dev, "the private feature 0x%x does not belong to any AFU.\n",
> +			feature_id(dfl->ioaddr + ofst));
>  		return -EINVAL;
>  	}
>  
> @@ -1424,7 +1425,7 @@ static int do_set_irq_trigger(struct dfl_feature *feature, unsigned int idx,
>  		return 0;
>  
>  	feature->irq_ctx[idx].name =
> -		kasprintf(GFP_KERNEL, "fpga-irq[%u](%s-%llx)", idx,
> +		kasprintf(GFP_KERNEL, "fpga-irq[%u](%s-%x)", idx,
>  			  dev_name(&pdev->dev), feature->id);
>  	if (!feature->irq_ctx[idx].name)
>  		return -ENOMEM;
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index a32dfba..bc61942 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -197,7 +197,7 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
>   * @id: unique dfl private feature id.
>   */
>  struct dfl_feature_id {
> -	u64 id;
> +	u16 id;
>  };
>  
>  /**
> @@ -240,7 +240,7 @@ struct dfl_feature_irq_ctx {
>   */
>  struct dfl_feature {
>  	struct platform_device *dev;
> -	u64 id;
> +	u16 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
>  	struct dfl_feature_irq_ctx *irq_ctx;
> @@ -365,7 +365,7 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
>  	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
>  
>  static inline
> -struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
> +struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>  	struct dfl_feature *feature;
> @@ -378,7 +378,7 @@ struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
>  }
>  
>  static inline
> -void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
> +void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
>  {
>  	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
>  
> @@ -389,7 +389,7 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
>  	return NULL;
>  }
>  
> -static inline bool is_dfl_feature_present(struct device *dev, u64 id)
> +static inline bool is_dfl_feature_present(struct device *dev, u16 id)
>  {
>  	return !!dfl_get_feature_ioaddr_by_id(dev, id);
>  }
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks
