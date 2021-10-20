Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74CC43441B
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Oct 2021 06:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhJTEYO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Oct 2021 00:24:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:7856 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhJTEYO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 20 Oct 2021 00:24:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="252169195"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="252169195"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 21:22:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="483561795"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2021 21:21:57 -0700
Date:   Wed, 20 Oct 2021 12:15:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v1 1/2] fpga: dfl: afu: Clear port errors in afu init
Message-ID: <20211020041526.GA146813@yilunxu-OptiPlex-7050>
References: <20211019231545.47118-1-russell.h.weight@intel.com>
 <20211019231545.47118-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019231545.47118-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 19, 2021 at 04:15:44PM -0700, Russ Weight wrote:
> When the AFU driver initializes, log any pre-existing errors and clear them.

Please wrapper the commit message to pass checkpatch.pl

> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl-afu-error.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index ab7be6217368..0dc60bf49902 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -47,13 +47,13 @@ static void afu_port_err_mask(struct device *dev, bool mask)
>  }
>  
>  /* clear port errors. */
> -static int afu_port_err_clear(struct device *dev, u64 err)
> +static int afu_port_err_clear(struct device *dev, u64 err, bool clear_all)

how about "clear_all_on_init"?

>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>  	struct platform_device *pdev = to_platform_device(dev);
> +	u64 v, port_error, port_first_error;
>  	void __iomem *base_err, *base_hdr;
>  	int enable_ret = 0, ret = -EBUSY;
> -	u64 v;
>  
>  	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
>  	base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> @@ -88,16 +88,21 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>  	__afu_port_err_mask(dev, true);
>  
>  	/* Clear errors if err input matches with current port errors.*/
> -	v = readq(base_err + PORT_ERROR);
> +	port_error = readq(base_err + PORT_ERROR);
>  
> -	if (v == err) {
> -		writeq(v, base_err + PORT_ERROR);
> +	if (clear_all || port_error == err) {
> +		port_first_error = readq(base_err + PORT_FIRST_ERROR);
>  
> -		v = readq(base_err + PORT_FIRST_ERROR);
> -		writeq(v, base_err + PORT_FIRST_ERROR);
> +		if (clear_all && (port_error || port_first_error))
> +			dev_warn(dev,
> +				 "Port Error: 0x%llx, First Error 0x%llx\n",
> +				 port_error, port_first_error);

The log could be more specific that we are reporting errors on device
initialization.

Thanks,
Yilun

> +
> +		writeq(port_error, base_err + PORT_ERROR);
> +		writeq(port_first_error, base_err + PORT_FIRST_ERROR);
>  	} else {
>  		dev_warn(dev, "%s: received 0x%llx, expected 0x%llx\n",
> -			 __func__, v, err);
> +			 __func__, port_error, err);
>  		ret = -EINVAL;
>  	}
>  
> @@ -137,7 +142,7 @@ static ssize_t errors_store(struct device *dev, struct device_attribute *attr,
>  	if (kstrtou64(buff, 0, &value))
>  		return -EINVAL;
>  
> -	ret = afu_port_err_clear(dev, value);
> +	ret = afu_port_err_clear(dev, value, false);
>  
>  	return ret ? ret : count;
>  }
> @@ -211,7 +216,8 @@ const struct attribute_group port_err_group = {
>  static int port_err_init(struct platform_device *pdev,
>  			 struct dfl_feature *feature)
>  {
> -	afu_port_err_mask(&pdev->dev, false);
> +	if (afu_port_err_clear(&pdev->dev, 0, true))
> +		afu_port_err_mask(&pdev->dev, false);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
