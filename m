Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29229471F2C
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Dec 2021 02:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhLMBgO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 12 Dec 2021 20:36:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:18316 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhLMBgN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 12 Dec 2021 20:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639359373; x=1670895373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SgvN0v5cm3b1H3nNm2OjkJCvMzZvIazV7y/iC/a9CJs=;
  b=JkGTDJMsskkdgRyLJbLOh3KkKuezuIyYxy5rvRfnf/7EuRt+dGVY5Two
   /1MQjjzvFGTpr/wq0rylQR0a2UcX/f4e2ACHj8pxJn6cZn6oVUeaRY4zs
   /eDsmKg3BZf7JliMDqEYqxpHJRMRTUCYB2jtzbupq8QqMjVH6BhLBe304
   a04XR3ynZAjK2ys1ae13fOHxtkrLGEm/Gmh6vfuRblwhz6J3ssowT2JCE
   NlLKCHSqsBNX6Lr3NVvVxp8mocR+d8qeNA6Gi0P7cH8EPRjMQ8SlKcRiH
   7j2cezQ+0BGh3KDDKJAp/tKDA2OihMFPhYi2GHQS3CS97r6nwTGc2f1U/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="218659264"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="218659264"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 17:36:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="660640743"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2021 17:36:11 -0800
Date:   Mon, 13 Dec 2021 09:28:46 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Jason Wang <wangborong@cdjrlc.com>, hao.wu@intel.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: stratix10-soc: fix typo in a comment
Message-ID: <20211213012846.GD336280@yilunxu-OptiPlex-7050>
References: <20211212031956.46029-1-wangborong@cdjrlc.com>
 <c10b3af5-5371-a4c0-bbe6-a29b3c3573ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10b3af5-5371-a4c0-bbe6-a29b3c3573ee@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Dec 12, 2021 at 08:19:00AM -0800, Tom Rix wrote:
> 
> On 12/11/21 7:19 PM, Jason Wang wrote:
> > The double `if' in the comment in line 288 is repeated. Remove one
> > of them from the comment.
> > 
> > Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> > ---
> >   drivers/fpga/stratix10-soc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> > index 357cea58ec98..e4f2e83a615b 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -285,7 +285,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
> >   	/*
> >   	 * Loop waiting for buffers to be returned.  When a buffer is returned,
> > -	 * reuse it to send more data or free if if all data has been sent.
> > +	 * reuse it to send more data or free if all data has been sent.
> 
> This looks fine.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Thanks,
Yilun

> 
> >   	 */
> >   	while (count > 0 || s10_free_buffer_count(mgr) != NUM_SVC_BUFS) {
> >   		reinit_completion(&priv->status_return_completion);
