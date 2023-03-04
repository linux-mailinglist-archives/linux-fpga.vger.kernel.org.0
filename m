Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC096AAAE7
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Mar 2023 16:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCDPla (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 4 Mar 2023 10:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCDPla (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 4 Mar 2023 10:41:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935513D6E;
        Sat,  4 Mar 2023 07:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677944469; x=1709480469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1O6X2bU+hlU9cc69CuzgjEH35kCbP1rkBwjWe5GsnTg=;
  b=ZmDAVdaRpVj5qKlUbs/Fbnt6F1QUqJFQqsguFjWb0SHSJGjxC9MvGhoj
   Ng9r85VEFUrA6s59U4+Kucmn+E2wWQxYLEQuJwt3jNoweUr2hRKWjB7pa
   LF9LMTTA/257tfmIiGkR0gnw/btCFCQ+rLDlrBXFNTGUYD+UdxizA4kwy
   3NL0Oj4d7YyVq55C/StGCcN4QTeZjsBdp1kHKeMNcV8Ezx6QzZCvhq4gS
   F82FpVxLkLBsu0dQc7RrUudLFtvbfY8NgweLswn8yDq1SRoM90ZSxIOgc
   e+KvCu33W9v8JxprTIfgbJD8IgQEO/JW/RKoJN51p/lEPmganQko+Tk6x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400089681"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="400089681"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 07:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="785645656"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="785645656"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 04 Mar 2023 07:41:07 -0800
Date:   Sat, 4 Mar 2023 23:29:59 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Tull <atull@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: bridge: fix kernel-doc parameter description
Message-ID: <ZANj9+SILtNZkqUE@yilunxu-OptiPlex-7050>
References: <20230301140309.512578-1-marpagan@redhat.com>
 <4e15feab-5d75-6748-324d-ff58d0f862b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e15feab-5d75-6748-324d-ff58d0f862b8@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-02 at 04:51:43 -0800, Tom Rix wrote:
> 
> On 3/1/23 6:03 AM, Marco Pagani wrote:
> > Fix the kernel-doc description for the "struct fpga_image_info *info"
> > parameter of the fpga_bridge_get() function.
> > 
> > Fixes: 060ac5c8fa7b ("fpga: bridge: kernel-doc fixes")
> > Signed-off-by: Marco Pagani <marpagan@redhat.com>
> Reviewed-by: Tom Rix <trix@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> > ---
> >   drivers/fpga/fpga-bridge.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> > index 5cd40acab5bf..ff4470067ed5 100644
> > --- a/drivers/fpga/fpga-bridge.c
> > +++ b/drivers/fpga/fpga-bridge.c
> > @@ -115,7 +115,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
> >   /**
> >    * fpga_bridge_get - get an exclusive reference to an fpga bridge
> >    * @dev:	parent device that fpga bridge was registered with
> > - * @info:	fpga manager info
> > + * @info:	fpga image specific information
> >    *
> >    * Given a device, get an exclusive reference to an fpga bridge.
> >    *
> 
