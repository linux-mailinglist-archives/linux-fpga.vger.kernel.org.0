Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706F3471F2A
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Dec 2021 02:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhLMBfw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 12 Dec 2021 20:35:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:62021 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhLMBfw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 12 Dec 2021 20:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639359352; x=1670895352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xh7qcH3qVpAgwK6kjC1aXJIEWzGh7VGOtD+NUU5Ik6M=;
  b=OQDlLRszVjIMMICMrsLbx4j9uB+aTGxFvpf5g/S3bZ+g6pnGaHtBTvQz
   ZnuwtmGYSDj0O4yPDLmoUL6sFDSnF7iFYhGLlHSL1Bnn/DK1DC2mg58IS
   NFMJwJxZMmf0xQgBVJU7ZhIpO1acsT0AVMekCHIKmBlyBycyG49Bjm+4u
   ISUUJZYiAOgrj+418gaeEuyoX+IOa4WWMcXL2Qu4Yhquv8hImbi+RQXKL
   Jv+yXca1wD33k79ixSUKKIX029PogL/n+PRWkPeiu0PQ9fg8+/ZqiDkbV
   IIIFGAKhBgrz1rVqkR+iKh90XWgmNDi1P9DsyxOxXqLix6azCuUq6p0hf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238868305"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="238868305"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 17:35:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="517554200"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2021 17:35:44 -0800
Date:   Mon, 13 Dec 2021 09:28:18 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org
Subject: Re: [PATCH v2] fpga: stratix10-soc: fix NULL vs IS_ERR() checking
Message-ID: <20211213012818.GC336280@yilunxu-OptiPlex-7050>
References: <b1186cd9-c29c-397b-080b-dcfc6b02525f@redhat.com>
 <20211211145038.31612-1-linmq006@gmail.com>
 <97789bcc-0e5b-a822-854f-15d0fbe47844@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97789bcc-0e5b-a822-854f-15d0fbe47844@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Dec 11, 2021 at 06:57:51AM -0800, Tom Rix wrote:
> 
> On 12/11/21 6:50 AM, Miaoqian Lin wrote:
> > The stratix10_svc_allocate_memory function does not return NULL. It
> > returns ERR_PTR(-ENOMEM). Use IS_ERR check the return value.
> > 
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >   drivers/fpga/stratix10-soc.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> > index 047fd7f23706..91212bab5871 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -213,9 +213,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
> >   	/* Allocate buffers from the service layer's pool. */
> >   	for (i = 0; i < NUM_SVC_BUFS; i++) {
> >   		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
> > -		if (!kbuf) {
> > +		if (IS_ERR(kbuf)) {
> >   			s10_free_buffers(mgr);
> > -			ret = -ENOMEM;
> > +			ret = PTR_ERR(kbuf);
> 
> Thanks!
> 
> Reviewed-by: Tom Rix <trix@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Thanks,
Yilun

> 
> >   			goto init_done;
> >   		}
