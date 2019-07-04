Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006785FADF
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jul 2019 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfGDPbC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Jul 2019 11:31:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:3318 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbfGDPbC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Jul 2019 11:31:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 08:31:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="172450290"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2019 08:30:58 -0700
Date:   Thu, 4 Jul 2019 23:14:17 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: use driver core functions, not sysfs ones.
Message-ID: <20190704151416.GA1423@hao-dev>
References: <20190704055645.GA15471@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704055645.GA15471@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 04, 2019 at 07:56:45AM +0200, Greg Kroah-Hartman wrote:
> This is a driver, do not call "raw" sysfs functions, instead call driver
> core ones.  Specifically convert the use of sysfs_create_files() and
> sysfs_remove_files() to use device_add_groups() and
> device_remove_groups()

Hi Greg,

Thanks for this patch. It looks good, and works well in my side.

I will follow the same (replace sysfs_create/remove_* with
device_add/remove_group) to rework my patchset too. Thanks.

Hao

> 
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/fpga/dfl-afu-main.c | 14 ++++++++------
>  drivers/fpga/dfl-fme-main.c |  7 ++++---
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 02baa6a227c0..68b4d0874b93 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -141,10 +141,11 @@ id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(id);
>  
> -static const struct attribute *port_hdr_attrs[] = {
> +static struct attribute *port_hdr_attrs[] = {
>  	&dev_attr_id.attr,
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(port_hdr);
>  
>  static int port_hdr_init(struct platform_device *pdev,
>  			 struct dfl_feature *feature)
> @@ -153,7 +154,7 @@ static int port_hdr_init(struct platform_device *pdev,
>  
>  	port_reset(pdev);
>  
> -	return sysfs_create_files(&pdev->dev.kobj, port_hdr_attrs);
> +	return device_add_groups(&pdev->dev, port_hdr_groups);
>  }
>  
>  static void port_hdr_uinit(struct platform_device *pdev,
> @@ -161,7 +162,7 @@ static void port_hdr_uinit(struct platform_device *pdev,
>  {
>  	dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
>  
> -	sysfs_remove_files(&pdev->dev.kobj, port_hdr_attrs);
> +	device_remove_groups(&pdev->dev, port_hdr_groups);
>  }
>  
>  static long
> @@ -214,10 +215,11 @@ afu_id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(afu_id);
>  
> -static const struct attribute *port_afu_attrs[] = {
> +static struct attribute *port_afu_attrs[] = {
>  	&dev_attr_afu_id.attr,
>  	NULL
>  };
> +ATTRIBUTE_GROUPS(port_afu);
>  
>  static int port_afu_init(struct platform_device *pdev,
>  			 struct dfl_feature *feature)
> @@ -234,7 +236,7 @@ static int port_afu_init(struct platform_device *pdev,
>  	if (ret)
>  		return ret;
>  
> -	return sysfs_create_files(&pdev->dev.kobj, port_afu_attrs);
> +	return device_add_groups(&pdev->dev, port_afu_groups);
>  }
>  
>  static void port_afu_uinit(struct platform_device *pdev,
> @@ -242,7 +244,7 @@ static void port_afu_uinit(struct platform_device *pdev,
>  {
>  	dev_dbg(&pdev->dev, "PORT AFU UInit.\n");
>  
> -	sysfs_remove_files(&pdev->dev.kobj, port_afu_attrs);
> +	device_remove_groups(&pdev->dev, port_afu_groups);
>  }
>  
>  static const struct dfl_feature_ops port_afu_ops = {
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 086ad2420ade..0be4635583d5 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -72,12 +72,13 @@ static ssize_t bitstream_metadata_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(bitstream_metadata);
>  
> -static const struct attribute *fme_hdr_attrs[] = {
> +static struct attribute *fme_hdr_attrs[] = {
>  	&dev_attr_ports_num.attr,
>  	&dev_attr_bitstream_id.attr,
>  	&dev_attr_bitstream_metadata.attr,
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(fme_hdr);
>  
>  static int fme_hdr_init(struct platform_device *pdev,
>  			struct dfl_feature *feature)
> @@ -89,7 +90,7 @@ static int fme_hdr_init(struct platform_device *pdev,
>  	dev_dbg(&pdev->dev, "FME cap %llx.\n",
>  		(unsigned long long)readq(base + FME_HDR_CAP));
>  
> -	ret = sysfs_create_files(&pdev->dev.kobj, fme_hdr_attrs);
> +	ret = device_add_groups(&pdev->dev, fme_hdr_groups);
>  	if (ret)
>  		return ret;
>  
> @@ -100,7 +101,7 @@ static void fme_hdr_uinit(struct platform_device *pdev,
>  			  struct dfl_feature *feature)
>  {
>  	dev_dbg(&pdev->dev, "FME HDR UInit.\n");
> -	sysfs_remove_files(&pdev->dev.kobj, fme_hdr_attrs);
> +	device_remove_groups(&pdev->dev, fme_hdr_groups);
>  }
>  
>  static const struct dfl_feature_ops fme_hdr_ops = {
> -- 
> 2.22.0
