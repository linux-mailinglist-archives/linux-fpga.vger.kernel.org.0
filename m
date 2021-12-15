Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E61475051
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Dec 2021 02:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhLOBKJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 14 Dec 2021 20:10:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:11409 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhLOBKJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 14 Dec 2021 20:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639530609; x=1671066609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p419YJnl6N9/x/smUi4dkMhI5rqPpm6B6apiobEu2QI=;
  b=dNiin+iL+ZD8e7EGAP/UqYv3VcG0wCR3OLbXa5A4ji0tXq84gZGVf7bZ
   b5QT255gEZwr9n+BO2W/Fsz51kXFM1ltY140Zt1oStdHf+1GtKYFOHPYL
   ePDfYBx78hIVsPctHvu6JROQOPYuA3yrRWb3poGtZlnKfJE4k0IlLe7X7
   k68Ve7eI6do1eUPs2In0lOr6Qb9jYsd89tgN+fWqoK52sHuaIdNdKBtFb
   gg925Hiye5zhi2opoMwOxdaivyiL6UDln1pmBUHU9gBdAS/3CYVallgSj
   rV9nE6J2+Cec7LoLnumtK0E+D55ZFdnBWhhh9RIqwkogMsW9pb+/N8+8C
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="237855572"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="237855572"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 17:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="545390647"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga001.jf.intel.com with ESMTP; 14 Dec 2021 17:10:07 -0800
Date:   Wed, 15 Dec 2021 09:02:39 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     trix@redhat.com, mdf@kernel.org, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: stratix10-soc: cleanup double word in comment
Message-ID: <20211215010239.GA787567@yilunxu-OptiPlex-7050>
References: <20211214154749.2463147-1-trix@redhat.com>
 <6d5f9555-47c5-c84e-a62d-73fbee78a483@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d5f9555-47c5-c84e-a62d-73fbee78a483@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Dec 14, 2021 at 08:59:45AM -0800, Russ Weight wrote:
> 
> 
> On 12/14/21 7:47 AM, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> >
> > There are two that's in the comment, remove one.
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Thanks,
Yilun

> 
> > ---
> >  drivers/fpga/stratix10-soc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> > index 357cea58ec98e..862069c95aa3c 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -245,7 +245,7 @@ static int s10_send_buf(struct fpga_manager *mgr, const char *buf, size_t count)
> >  	int ret;
> >  	uint i;
> >  
> > -	/* get/lock a buffer that that's not being used */
> > +	/* get/lock a buffer that is not being used */
> >  	for (i = 0; i < NUM_SVC_BUFS; i++)
> >  		if (!test_and_set_bit_lock(SVC_BUF_LOCK,
> >  					   &priv->svc_bufs[i].lock))
