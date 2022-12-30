Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9370165943E
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 03:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiL3CoM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 21:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiL3CoL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 21:44:11 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E12189;
        Thu, 29 Dec 2022 18:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672368250; x=1703904250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W1cu+psy3UKnw7BrB+yN0znRmXff8NyPQPr+AbOVv7Y=;
  b=PMfVaeZK3hfe0LDWvsE7cq6UKdR7FhiaiIiba+JbGH4Wi0tCQx8fl6wT
   m/VlyWbS3UrvF98uZsfdUyHLbpP0Nno1tUnl2agFqtDVWZJS2KJWMvGnA
   8F+sStnDXd8s6ZvN3ZjuuLWjySYlfXaPHqSp7QmamzW45aO/gZ++8DeD7
   F4/dOSWt+6XzjHvzye5jE+6v4ASTIJSWt2Wgem76b72GkDSLv7EVJaozU
   Zeyl2yYD5UYy5eSij8urwGyIBsjzlXWg5aFD3ddzW3CLnmNTVTA0ze6U9
   oAFvRSprYpkqk77nYRKUUSBJ932lhVJUUflgnZE/5Y2kotdPUTiUITyOd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="385574965"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="385574965"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 18:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="796120600"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="796120600"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2022 18:44:07 -0800
Date:   Fri, 30 Dec 2022 10:34:00 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>, mdf@kernel.org,
        hao.wu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com
Subject: Re: [PATCH] fpga: stratix10-soc: Fix return value check in
 s10_ops_write_init()
Message-ID: <Y65OGF4UPnjFOutm@yilunxu-OptiPlex-7050>
References: <20221126071430.19540-1-zhengyongjun3@huawei.com>
 <bdb1a752-ed47-1f9f-8a71-7b85e80bd547@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb1a752-ed47-1f9f-8a71-7b85e80bd547@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-28 at 17:26:23 -0800, Russ Weight wrote:
> 
> 
> On 11/25/22 23:14, Zheng Yongjun wrote:
> > In case of error, the function stratix10_svc_allocate_memory()
> > returns ERR_PTR() and never returns NULL. The NULL test in the
> > return value check should be replaced with IS_ERR().
> >
> > Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-6.2 and Cc: stable@vger.kernel.org

> > ---
> >  drivers/fpga/stratix10-soc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> > index 357cea58ec98..f7f01982a512 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -213,9 +213,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
> >  	/* Allocate buffers from the service layer's pool. */
> >  	for (i = 0; i < NUM_SVC_BUFS; i++) {
> >  		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
> > -		if (!kbuf) {
> > +		if (IS_ERR(kbuf)) {
> >  			s10_free_buffers(mgr);
> > -			ret = -ENOMEM;
> > +			ret = PTR_ERR(kbuf);
> >  			goto init_done;
> >  		}
> >
> > --
> > 2.17.1
> >
> 
