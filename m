Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C732691B92
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Feb 2023 10:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjBJJfj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Feb 2023 04:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjBJJfi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Feb 2023 04:35:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D7D7B15D;
        Fri, 10 Feb 2023 01:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676021709; x=1707557709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7JzvmP4zHGmpUE7KTsl5GCUzo4xaLUZubGQveSA0S+U=;
  b=DiibNd0JLu6IG5Bs+erZvTRvFHQDxRInpX54Lyfy2yE9mPmrAjiZ27K+
   tbcU7SE+8AU1AkM1netVsP2SvK4EccKRbl/5JebocpQ7DTmmo56CVsJe5
   UBNwL0lM/9/3MDdIIRubY0OUv0ebAX6D8Rhym0dw2uV+T8zNRZA2TEsJW
   +QkXxrgXO7lJ/XCTs6OIX2FJWmbS4Sv/n4MqPpifGvLk1bBblClc8cO7C
   l6vxk3+P+UT12TWfxi0Gn6TqL/wp3x0180FQh87qnDw6xknrLSKO1qaT7
   M9UINf2NjbxJDfHZnXukv8WResz2d+Lyp4JXqcm9KAxkUv/MooeRHYWh6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416605661"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="416605661"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="996906613"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="996906613"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 01:35:00 -0800
Date:   Fri, 10 Feb 2023 17:24:14 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Lee Jones <lee@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: m10bmc-sec: Fix rsu_send_data() to return
 FW_UPLOAD_ERR_HW_ERROR
Message-ID: <Y+YNPtNxAcwugkAs@yilunxu-OptiPlex-7050>
References: <20230208080846.10795-1-ilpo.jarvinen@linux.intel.com>
 <79d47a18-90dd-9fc2-aa0e-ca5627b7ca6d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79d47a18-90dd-9fc2-aa0e-ca5627b7ca6d@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-08 at 11:28:26 -0800, Russ Weight wrote:
> 
> On 2/8/23 00:08, Ilpo Järvinen wrote:
> > rsu_send_data() should return FW_UPLOAD_ERR_* error codes instead of
> > normal -Exxxx codes. Convert <0 return from ->rsu_status() to
> > FW_UPLOAD_ERR_HW_ERROR.
> >
> > Fixes: 001a734a55d0 ("fpga: m10bmc-sec: Make rsu status type specific")
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >
> > ---
> >  drivers/fpga/intel-m10-bmc-sec-update.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > index f0acedc80182..d7e2f9f461bc 100644
> > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > @@ -474,7 +474,7 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
> >  
> >  	ret = sec->ops->rsu_status(sec);
> >  	if (ret < 0)
> > -		return ret;
> > +		return FW_UPLOAD_ERR_HW_ERROR;
> >  	status = ret;
> >  
> >  	if (!rsu_status_ok(status)) {
> >
> 
