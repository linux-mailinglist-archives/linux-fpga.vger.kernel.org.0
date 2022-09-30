Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1B25F0418
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Sep 2022 07:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiI3FKl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Sep 2022 01:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiI3FKk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Sep 2022 01:10:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6CE9058;
        Thu, 29 Sep 2022 22:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664514639; x=1696050639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jaVg7DcNakCTHSKXrsLVNn/gQgHAGjnRUrdm5AclUcc=;
  b=PTqxsy+JwBk8150sPgR031qgstGIcsqQcxWrVfYHL+OvjSZrKycmTu3D
   Yai1DcR2u6F/mP3iyO3Of6rYHMSQHD20wCbiwMdcEwKSyk7muQUevHfNz
   R2HEGdLf8KbFEp6UoRMjAc9ZxbhFUtK7AYnjH8vuZRGixSMk+6oe//7eW
   M7tJgSYy1FpzH7Xc4U1FpoCgonvGpMF1noAvdwJLsuGhFsDUBmdavLAfM
   r7HDVzwQRiOurazm/y+A9RuPEL2ZflJnQV4u8WLu9FBzZ0RQgY861bzfl
   X6FYcOZLCJnhTfo5pB4jFikk0qs+wGY/LuuIh92RmhlDKmxuqlRAdykqh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="302078960"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="302078960"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 22:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="726719693"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="726719693"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 29 Sep 2022 22:10:33 -0700
Date:   Fri, 30 Sep 2022 13:01:44 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        russell.h.weight@intel.com, basheer.ahmed.muddebihal@intel.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v2 2/6] fpga: dfl: Move the DFH definitions
Message-ID: <YzZ4ODnnLm+HOFCg@yilunxu-OptiPlex-7050>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
 <20220923121745.129167-3-matthew.gerlach@linux.intel.com>
 <36342784-34c3-6a08-7cd4-eb185b61061a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36342784-34c3-6a08-7cd4-eb185b61061a@redhat.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-24 at 06:00:19 -0700, Tom Rix wrote:
> 
> On 9/23/22 5:17 AM, matthew.gerlach@linux.intel.com wrote:
> > From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> > 
> > Moving the DFH register offset and register definitions from
> > drivers/fpga/dfl.h to include/linux/dfl.h. These definitions
> > need to be accessed by dfl drivers that are outside of
> > drivers/fpga.
> 
> This comment does not match what is done.
> 
> A move, a change in names and the introduction new defines.
> 
> I am not sure if moving these #defines is the best approach, the later use
> of the in the uart with FIELD_GET's i think should be wrapped as functions
> and these functions exported rather than the #defines.

I agree, to play with all domains across kernel, we'd better not expose
too much bus specific details.

Thanks,
Yilun
