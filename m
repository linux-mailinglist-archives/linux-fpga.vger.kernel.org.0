Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FED522ED5
	for <lists+linux-fpga@lfdr.de>; Wed, 11 May 2022 10:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiEKI4k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 11 May 2022 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiEKI4k (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 11 May 2022 04:56:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7182ED63;
        Wed, 11 May 2022 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652259399; x=1683795399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8dg4yzRBIiATtcgtswM0d5GT2lm9nRUGUGY9LgpGxCs=;
  b=R3j6LFfYTqo/rK5vfxi6fpvkt2TXbZKStwWoVgcrE2aPPIXcXdOmdng1
   nomwe4cWCjaBBvXjwHN7zCXEpu/h0cNa5V0JZ2lJGYtzj9GxQ1NwOYhQn
   7w3D8Z+wLe5o96F0i/JVQE2d6egFDTVX/kEOZVLozQbOwa19US+cn9W4h
   3jQiqrdLIXz/cgXeS8j3RLNyqrlmSi/2g92AJS4WpXMPqvHHKSBGMA8Ev
   VepjvIa7DjMbv0QSZScL4IE2l87JiqNPCqyJccDy50bVSiM9sTbFxUtdx
   KDETH+/pqEPlBhG0COZVsAEHwFa0wZA95uuZ4dDwLbvWQYwANmwpRVJSC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249534748"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="249534748"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 01:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="594017689"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2022 01:56:36 -0700
Date:   Wed, 11 May 2022 16:48:38 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Wu Hao <hao.wu@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Message-ID: <20220511084838.GA487393@yilunxu-OptiPlex-7050>
References: <YnkE8AbimDa7sfN8@kili>
 <20220509170015.GC470015@yilunxu-OptiPlex-7050>
 <20220511083329.GN4031@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511083329.GN4031@kadam>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, May 11, 2022 at 11:33:29AM +0300, Dan Carpenter wrote:
> On Tue, May 10, 2022 at 01:00:15AM +0800, Xu Yilun wrote:
> > 
> > Hi Dan & Moritz:
> > 
> > Thanks for the patch. But it actually reverts Nava's patch. Since Nava's
> > patch is not pushed to linux-next yet, could we just drop it from
> > linux-fpga?
> 
> I don't know if you meant linux-next.  It's pushed to linux-next.  But
> linux-next is rebased every day so reverting is fine as far as linux-next
> goes.

Thanks for the info. I was not aware of that and may mess up something.
I force pushed the linux-fpga yesterday for this patchset, then linux-next
would be conflict with linux-fpga, is it?

If it is the case, how could I remedy?

Thanks,
Yilun

> 
> regards,
> dan carpenter
