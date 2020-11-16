Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DBB2B3D8C
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Nov 2020 08:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgKPHOg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Nov 2020 02:14:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:29496 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbgKPHOf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 02:14:35 -0500
IronPort-SDR: MPAm9JuDfNNveMaBqBOxRP0nMXb4e7YkkX1AdmcinNi5g+BwgH+/iFCaeSn+rqR5xY1+Fxs98D
 iR1W+jNWsCDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="150558658"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="150558658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 23:14:33 -0800
IronPort-SDR: fzhVjJgoNi3dybV+CnH3k9oNR+A3RAKt7fzc+9ncjHvQwTJZ6HcxahHuwa2LZXAaONGIbZ+7Sb
 BCmeRTK1ccfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="475431287"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2020 23:14:31 -0800
Date:   Mon, 16 Nov 2020 15:10:23 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, yilun.xu@intel.com
Subject: Re: [RESEND PATCH 03/10] fpga: fpga-mgr: dfl-fme-mgr: Simplify
 registration
Message-ID: <20201116071023.GB8715@yilunxu-OptiPlex-7050>
References: <20201115195127.284487-1-mdf@kernel.org>
 <20201115195127.284487-4-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115195127.284487-4-mdf@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Tested on DFL FPGA platform, it is OK.

Thanks,
Yilun

On Sun, Nov 15, 2020 at 11:51:20AM -0800, Moritz Fischer wrote:
> Simplify registration using new devm_fpga_mgr_register() API.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-mgr.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index b3f7eee3c93f..d5861d13b306 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -314,18 +314,8 @@ static int fme_mgr_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mgr->compat_id = compat_id;
> -	platform_set_drvdata(pdev, mgr);
>  
> -	return fpga_mgr_register(mgr);
> -}
> -
> -static int fme_mgr_remove(struct platform_device *pdev)
> -{
> -	struct fpga_manager *mgr = platform_get_drvdata(pdev);
> -
> -	fpga_mgr_unregister(mgr);
> -
> -	return 0;
> +	return devm_fpga_mgr_register(dev, mgr);
>  }
>  
>  static struct platform_driver fme_mgr_driver = {
> @@ -333,7 +323,6 @@ static struct platform_driver fme_mgr_driver = {
>  		.name    = DFL_FPGA_FME_MGR,
>  	},
>  	.probe   = fme_mgr_probe,
> -	.remove  = fme_mgr_remove,
>  };
>  
>  module_platform_driver(fme_mgr_driver);
> -- 
> 2.29.2
