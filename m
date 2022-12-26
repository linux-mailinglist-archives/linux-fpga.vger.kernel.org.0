Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7DC655FA4
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 05:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiLZD6U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Dec 2022 22:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZD6U (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Dec 2022 22:58:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5057F26D4;
        Sun, 25 Dec 2022 19:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672027099; x=1703563099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Zg69wlDFLaNoP+dcrRtsKjwz24O2TMBqloyI+EYtQ6w=;
  b=eTBMRSp8j+dcx7i79/CLL4me/HpzdjzmrbRg+esQjg8198SFr6fKE9Hk
   CPlVi8Zn6THoRhP+Mxpi+g6VJxOV1+2C1Ehb4MhYoWY0Bf+2Od6+1V90E
   sMGiPAyHGqabojhIBl3iJc6qPcYW9EC+1mYGnMbkjxDirFD02DxQTbw/W
   SOufQyzf6vx9g/spKPspv3D9nbBp5JtcYmSWRYXYWceLti8XqNgykEE33
   JqBATeSqHAjuPdjSYQxoqLObq0og9unCoThxRhvVvl6IdtsL1/C3P2WNj
   2wh5K2APbqF2AVgiUYMlTc7W2a7EFQzILjXMocEKIECzB3cTpbBDJoZH0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="347708222"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="347708222"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 19:58:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="794985158"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="794985158"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 25 Dec 2022 19:58:16 -0800
Date:   Mon, 26 Dec 2022 11:48:12 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Marco Pagani <marpagan@redhat.com>
Subject: Re: [PATCH v2 1/1] fpga: m10bmc-sec: Fix probe rollback
Message-ID: <Y6kZfHOCb18qmaeP@yilunxu-OptiPlex-7050>
References: <20221214144952.8392-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214144952.8392-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-14 at 16:49:52 +0200, Ilpo Järvinen wrote:
> Handle probe error rollbacks properly to avoid leaks.
> 
> Fixes: 5cd339b370e2 ("fpga: m10bmc-sec: add max10 secure update functions")
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Marco Pagani <marpagan@redhat.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

I assume this should be in stable kernel, so
 
 Cc: stable@vger.kernel.org

If OK, I could add it myself.

Thanks,
Yilun

> ---
> I don't know if the previous one fell through cracks so resending this.
> 
> v2:
> - Resending v1 with Marco's Rev-by
> 
>  drivers/fpga/intel-m10-bmc-sec-update.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 79d48852825e..03f1bd81c434 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -574,20 +574,27 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
>  	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
>  			sec->fw_name_id);
>  	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
> -	if (!sec->fw_name)
> -		return -ENOMEM;
> +	if (!sec->fw_name) {
> +		ret = -ENOMEM;
> +		goto fw_name_fail;
> +	}
>  
>  	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
>  				       &m10bmc_ops, sec);
>  	if (IS_ERR(fwl)) {
>  		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
> -		kfree(sec->fw_name);
> -		xa_erase(&fw_upload_xa, sec->fw_name_id);
> -		return PTR_ERR(fwl);
> +		ret = PTR_ERR(fwl);
> +		goto fw_uploader_fail;
>  	}
>  
>  	sec->fwl = fwl;
>  	return 0;
> +
> +fw_uploader_fail:
> +	kfree(sec->fw_name);
> +fw_name_fail:
> +	xa_erase(&fw_upload_xa, sec->fw_name_id);
> +	return ret;
>  }
>  
>  static int m10bmc_sec_remove(struct platform_device *pdev)
> -- 
> 2.30.2
> 
