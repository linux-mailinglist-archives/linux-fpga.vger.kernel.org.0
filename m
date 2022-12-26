Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84CC656463
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 19:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiLZR6H (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 12:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLZR6G (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 12:58:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F721034;
        Mon, 26 Dec 2022 09:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672077485; x=1703613485;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=itMV9pPy7ecW6wqmujU+SjOUyP24n6AQ4B0SuhgGPEI=;
  b=DGw0tquce+Aq4/Sct4mRM+TBy/ksy24NKi2Pu6wiD11gnfIcRB+3tu1D
   bqYOWq7ppH/1WbZJD8YYEw0YW5unN4EDdDDFgZzcN+BYtrNcYIFR/7QGJ
   iK7MezGHiOuGKhMH+WcHLm476HOTraxOX8Bx24q1BLiHhxMi9F5eFJV86
   XOyWLM0ctN/DPxncCb27zmaR1jFPSg8AyxDj6ZGJJM7qxCL33Axw/z0e6
   JnviaM1mn7i+U1VkGu2+f/Kdg9KcABPC4G7cI6My1oa/tatjSOPMSDOqQ
   o8NKaSLtNpLErPeaREivNH2conE+COTtZbr0NFNCeAe1KHD/vwo24IW3X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="382888271"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="382888271"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:58:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="652831451"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="652831451"
Received: from ptelkov-mobl2.ccr.corp.intel.com ([10.249.41.4])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:58:01 -0800
Date:   Mon, 26 Dec 2022 19:57:51 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
cc:     Russ Weight <russell.h.weight@intel.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Marco Pagani <marpagan@redhat.com>
Subject: Re: [PATCH v2 1/1] fpga: m10bmc-sec: Fix probe rollback
In-Reply-To: <Y6kZfHOCb18qmaeP@yilunxu-OptiPlex-7050>
Message-ID: <d435beb-f076-5212-ae7a-b3dedcb654e@linux.intel.com>
References: <20221214144952.8392-1-ilpo.jarvinen@linux.intel.com> <Y6kZfHOCb18qmaeP@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-566868870-1672077484=:1690"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-566868870-1672077484=:1690
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 26 Dec 2022, Xu Yilun wrote:

> On 2022-12-14 at 16:49:52 +0200, Ilpo Järvinen wrote:
> > Handle probe error rollbacks properly to avoid leaks.
> > 
> > Fixes: 5cd339b370e2 ("fpga: m10bmc-sec: add max10 secure update functions")
> > Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > Reviewed-by: Marco Pagani <marpagan@redhat.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> I assume this should be in stable kernel, so
>  
>  Cc: stable@vger.kernel.org
> 
> If OK, I could add it myself.

Yes, it should have been there but I forgot it.

Please add it like you suggested. Thanks.

-- 
 i.

> > ---
> > I don't know if the previous one fell through cracks so resending this.
> > 
> > v2:
> > - Resending v1 with Marco's Rev-by
> > 
> >  drivers/fpga/intel-m10-bmc-sec-update.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > index 79d48852825e..03f1bd81c434 100644
> > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > @@ -574,20 +574,27 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
> >  	len = scnprintf(buf, SEC_UPDATE_LEN_MAX, "secure-update%d",
> >  			sec->fw_name_id);
> >  	sec->fw_name = kmemdup_nul(buf, len, GFP_KERNEL);
> > -	if (!sec->fw_name)
> > -		return -ENOMEM;
> > +	if (!sec->fw_name) {
> > +		ret = -ENOMEM;
> > +		goto fw_name_fail;
> > +	}
> >  
> >  	fwl = firmware_upload_register(THIS_MODULE, sec->dev, sec->fw_name,
> >  				       &m10bmc_ops, sec);
> >  	if (IS_ERR(fwl)) {
> >  		dev_err(sec->dev, "Firmware Upload driver failed to start\n");
> > -		kfree(sec->fw_name);
> > -		xa_erase(&fw_upload_xa, sec->fw_name_id);
> > -		return PTR_ERR(fwl);
> > +		ret = PTR_ERR(fwl);
> > +		goto fw_uploader_fail;
> >  	}
> >  
> >  	sec->fwl = fwl;
> >  	return 0;
> > +
> > +fw_uploader_fail:
> > +	kfree(sec->fw_name);
> > +fw_name_fail:
> > +	xa_erase(&fw_upload_xa, sec->fw_name_id);
> > +	return ret;
> >  }
> >  
> >  static int m10bmc_sec_remove(struct platform_device *pdev)
> > -- 
> > 2.30.2
> > 
> 

--8323329-566868870-1672077484=:1690--
