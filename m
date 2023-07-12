Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E0074FCD4
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Jul 2023 03:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjGLBoT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Jul 2023 21:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGLBoS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Jul 2023 21:44:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5633D1717;
        Tue, 11 Jul 2023 18:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689126253; x=1720662253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5pOQqiTYbjzWAxv1kjdZf1mILm6585ylD9tNeo1102Q=;
  b=HinER0FtY39VlryagLkTp11tzXWI0/HhcYwH3i0CoMDPD+ey9C+IO0wc
   bXq5SwbnC+gR7YKBTjZpnWcgkNQ2zh/Doopbdlms43Zo9lz1+6/FK1HcU
   8wYU27S6JVb6hBVotep9SONKqfYObZhh1SU6d2syP7kDr284LDOrQUnod
   Jj9ETLS7vJFCyylM8NZcBvopgWUKIohuKzSAgXsUBFQQPooyRtwipqamg
   /ppSMkrfFhO1V6nfF75KXydycSdYW9iWYRnaW3qqfCNxzb1O5z0MxwClA
   0lJT2dfNAoVB3yE2qpDEfUgcyLbir63DsuIRLB3G9CtfxrxJyYEfUvBMc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="349629565"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="349629565"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 18:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="834931580"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="834931580"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2023 18:44:11 -0700
Date:   Wed, 12 Jul 2023 09:42:41 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, frank.li@vivo.com
Cc:     Yangtao Li <frank.li@vivo.com>, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fpga: socfpga-a10: Fix incorrect return value of
 devm_regmap_init_mmio
Message-ID: <ZK4FEdv6j+83+7nV@yilunxu-OptiPlex-7050>
References: <20230710133830.65631-1-frank.li@vivo.com>
 <20230710133830.65631-3-frank.li@vivo.com>
 <2023071010-anatomy-paying-3e3e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023071010-anatomy-paying-3e3e@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-10 at 16:11:35 +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 10, 2023 at 09:38:30PM +0800, Yangtao Li wrote:
> > When devm_regmap_init_mmio fails, we should return PTR_ERR(priv->regmap)
> > instead of -ENODEV.
> > 
> > Fixes: acbb910ae04b ("fpga-manager: Add Socfpga Arria10 support")
> 
> Why are you not also including a cc: stable@ tag here?

The change is to propagate the error number produced by regmap, instead
of using a fixed error number.

I think this is more of an improvement, not a bug fix. So no need to
merge to stable? And the changelog should be improved to avoid
confusing.

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h
