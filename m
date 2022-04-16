Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE6503773
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiDPQDF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 12:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPQDF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 12:03:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3609F6E7
        for <linux-fpga@vger.kernel.org>; Sat, 16 Apr 2022 09:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650124832; x=1681660832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vky81R1mG182RqB83yqiX7ur2bU30K+rUOTWOeYEAH4=;
  b=QLABmgkjoX5Q+HYzQew+V3BZ2JoV+C0l+XLHpUabtpabGE2D3XuM5Z50
   AuMFXiAv0wNSx/+arYnMozhg/fqYJNDUuzJfG/uU0kaqfF/JqqMZz5hLb
   6ERZtN0ONs5hG24nwMT0vZ+dHa3NHRZq70t9VFj60holSxOkyd4Xil4Yp
   OSZdF7M0kc/ZB3qlO15Niq0lS7lJZ8YJpbsCTlJ2jJ+WoVp0IWJe4hpmX
   7m6kJIQTmVMdFfOF7D9OzKr05CNmcmf2FN2JG2wuHzHqcdNHaZe0WRKWf
   7N6gX0ly/CkI59xqRUyBgwSWntEpplkyhLOHAH9xD2V6nVi6/P7ZU8OYf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="288376366"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="288376366"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 09:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="726124703"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2022 09:00:30 -0700
Date:   Sat, 16 Apr 2022 23:52:58 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v1] fpga: dfl: fme: adding reserved bits for revision of
 FME/Port error
Message-ID: <20220416155258.GB301222@yilunxu-OptiPlex-7050>
References: <20220412063523.54587-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412063523.54587-1-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Apr 12, 2022 at 02:35:23AM -0400, Tianfei Zhang wrote:
> From: Tianfei zhang <tianfei.zhang@intel.com>
> 
> There are 2 different register layouts for FME/Port error
> registers. This patch introduces 4 reserved bits (Bit[59:56])
> to indicate the revision of register layout for userland
> application.

Please specify that the 4 bits are reserved by HW so that SW appends
revision info on these bits for the attr readout value.

> 
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl-fme-error.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
> index 51c2892ec06d..3b54470f56ca 100644
> --- a/drivers/fpga/dfl-fme-error.c
> +++ b/drivers/fpga/dfl-fme-error.c
> @@ -39,6 +39,22 @@
>  
>  #define ERROR_MASK		GENMASK_ULL(63, 0)
>  
> +/* Bit[59:56] was reserved by software for error revision */
> +#define ERROR_SW_REVISION_MASK GENMASK_ULL(59, 56)

This will change the user behavior for the error interfaces. Now they
need to recognize the revision bits and discard them before clearing
the errors, is it?

How users know the revision fields in output values? Maybe it still
involves change in Documentation/ABI/testing/sysfs-platform-dfl-fme,
which should be reconsidered carefully.

> +
> +static u64 set_error_revision(struct device *dev, u64 value)
> +{
> +	void __iomem *base;
> +	u64 dfh;
> +	u64 revision;

Better we follow the reverse xmas tree declaration, so reverse the 2
lines please.

Thanks,
Yilun

> +
> +	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
> +	dfh = readq(base);
> +	revision = FIELD_GET(DFH_REVISION, dfh);
> +
> +	return value | FIELD_PREP(ERROR_SW_REVISION_MASK, revision);
> +}
> +
>  static ssize_t pcie0_errors_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> @@ -52,7 +68,8 @@ static ssize_t pcie0_errors_show(struct device *dev,
>  	value = readq(base + PCIE0_ERROR);
>  	mutex_unlock(&pdata->lock);
>  
> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> +	return sprintf(buf, "0x%llx\n",
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>  
>  static ssize_t pcie0_errors_store(struct device *dev,
> @@ -97,7 +114,8 @@ static ssize_t pcie1_errors_show(struct device *dev,
>  	value = readq(base + PCIE1_ERROR);
>  	mutex_unlock(&pdata->lock);
>  
> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> +	return sprintf(buf, "0x%llx\n",
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>  
>  static ssize_t pcie1_errors_store(struct device *dev,
> @@ -133,11 +151,13 @@ static ssize_t nonfatal_errors_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	void __iomem *base;
> +	u64 value;
>  
>  	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
> +	value = readq(base + RAS_NONFAT_ERROR);
>  
>  	return sprintf(buf, "0x%llx\n",
> -		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>  static DEVICE_ATTR_RO(nonfatal_errors);
>  
> @@ -145,11 +165,13 @@ static ssize_t catfatal_errors_show(struct device *dev,
>  				    struct device_attribute *attr, char *buf)
>  {
>  	void __iomem *base;
> +	u64 value;
>  
>  	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
> +	value = readq(base + RAS_CATFAT_ERROR);
>  
>  	return sprintf(buf, "0x%llx\n",
> -		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>  static DEVICE_ATTR_RO(catfatal_errors);
>  
> @@ -165,9 +187,10 @@ static ssize_t inject_errors_show(struct device *dev,
>  	mutex_lock(&pdata->lock);
>  	v = readq(base + RAS_ERROR_INJECT);
>  	mutex_unlock(&pdata->lock);
> +	v = FIELD_GET(INJECT_ERROR_MASK, v);
>  
>  	return sprintf(buf, "0x%llx\n",
> -		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
> +		       (unsigned long long)set_error_revision(dev, v));
>  }
>  
>  static ssize_t inject_errors_store(struct device *dev,
> @@ -211,7 +234,8 @@ static ssize_t fme_errors_show(struct device *dev,
>  	value = readq(base + FME_ERROR);
>  	mutex_unlock(&pdata->lock);
>  
> -	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
> +	return sprintf(buf, "0x%llx\n",
> +		       (unsigned long long)set_error_revision(dev, value));
>  }
>  
>  static ssize_t fme_errors_store(struct device *dev,
> -- 
> 2.26.2
