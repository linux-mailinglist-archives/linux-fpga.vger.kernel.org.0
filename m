Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5409166AC34
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Jan 2023 16:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjANPku (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 14 Jan 2023 10:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjANPkt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 14 Jan 2023 10:40:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3A7EC7;
        Sat, 14 Jan 2023 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673710849; x=1705246849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M25GkKQeLh+R1ElCPcHFYj/TtwVpy9Dn41SV9soMg2E=;
  b=C2jM6sgIJubCy5U+TNhlK+DQz4DX2vYx8zZzmuMTdqUiADmXDdvjcCni
   VjXHiJgZwuc1ViQ9E8Urjv7IxqaD3Fe3++xwllREKJgVh7EVwKno0j9w+
   G84496xI2N6aCHt11W8lbQDCp22r/Ca9Ool7/kYb1cvdcn06DB0RQTgBi
   GPiPb++rVnFIi8CergiXkoajSkH2dsL/sdObwAs5pv8cqMT2SgsLrSjeG
   ScuI1aFd/tdzB1xbImziNNmJmPGZL5nEw40/ClPHfVukcRwcPCFtqvvcb
   mVUyYk5rl7rAS4Bw4ajzMzNkzd/o4wFPISK9gECHE2uU+3vD+i+EmF49Q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="303902081"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="303902081"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 07:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10590"; a="800916238"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="800916238"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2023 07:40:46 -0800
Date:   Sat, 14 Jan 2023 23:30:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: kernel-doc corrections
Message-ID: <Y8LKkPktA9fUuUnX@yilunxu-OptiPlex-7050>
References: <20230113063720.10668-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113063720.10668-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-12 at 22:37:20 -0800, Randy Dunlap wrote:
> Fix W=1 kernel-doc warnings in drivers/fpga/:
> 
> drivers/fpga/dfl.c:54: warning: cannot understand function prototype: 'struct dfl_dev_info '
> drivers/fpga/dfl.c:74: warning: cannot understand function prototype: 'struct dfl_chardev_info '
> drivers/fpga/dfl-fme-pr.c:175: warning: Function parameter or member 'feature' not described in 'dfl_fme_create_mgr'
> drivers/fpga/dfl-fme-pr.c:280: warning: expecting prototype for dfl_fme_destroy_bridge(). Prototype was for dfl_fme_destroy_bridges() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next

> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: linux-fpga@vger.kernel.org
> ---
>  drivers/fpga/dfl-fme-pr.c |    4 ++--
>  drivers/fpga/dfl.c        |    5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff -- a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -45,7 +45,7 @@ static const char *dfl_pdata_key_strings
>  };
>  
>  /**
> - * dfl_dev_info - dfl feature device information.
> + * struct dfl_dev_info - dfl feature device information.
>   * @name: name string of the feature platform device.
>   * @dfh_id: id value in Device Feature Header (DFH) register by DFL spec.
>   * @id: idr id of the feature dev.
> @@ -67,7 +67,7 @@ static struct dfl_dev_info dfl_devs[] =
>  };
>  
>  /**
> - * dfl_chardev_info - chardev information of dfl feature device
> + * struct dfl_chardev_info - chardev information of dfl feature device
>   * @name: nmae string of the char device.
>   * @devt: devt of the char device.
>   */
> @@ -708,6 +708,7 @@ struct build_feature_devs_info {
>   * struct dfl_feature_info - sub feature info collected during feature dev build
>   *
>   * @fid: id of this sub feature.
> + * @revision: revision value of this sub feature.
>   * @mmio_res: mmio resource of this sub feature.
>   * @ioaddr: mapped base address of mmio resource.
>   * @node: node in sub_features linked list.
> diff -- a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -164,7 +164,7 @@ free_exit:
>  
>  /**
>   * dfl_fme_create_mgr - create fpga mgr platform device as child device
> - *
> + * @feature: sub feature info
>   * @pdata: fme platform_device's pdata
>   *
>   * Return: mgr platform device if successful, and error code otherwise.
> @@ -273,7 +273,7 @@ static void dfl_fme_destroy_bridge(struc
>  }
>  
>  /**
> - * dfl_fme_destroy_bridge - destroy all fpga bridge platform device
> + * dfl_fme_destroy_bridges - destroy all fpga bridge platform device
>   * @pdata: fme platform device's pdata
>   */
>  static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
