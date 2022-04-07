Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B536C4F76A0
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Apr 2022 08:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiDGG5d (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Apr 2022 02:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiDGG5b (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Apr 2022 02:57:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098626553;
        Wed,  6 Apr 2022 23:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649314532; x=1680850532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8cY/HD592AL6q7NPOD/NPQfxvapMBjLaxqhPPMiIjWY=;
  b=FJ+rFRaoxc+6chNKcjTcFCthS4PQnwcUv+WymW9Wg60QM594b/bczNMp
   3SZBEOtWKZG9+sVKbToXTLsmkouitjH0VmMGcWawyVzbuOwKAtBUQ++xM
   COYZO7FDPmcxNsOeU3hH/Vr+du1gp8oggkGkOPjFZb2ojd2yv+Em/HlbF
   U5V0gg7LE79XuXhMpXujSsYaN29FN73+HsR9bjYHuHWcaoNRv3YAu+1OA
   zNSxI7iAVogwD2lXbuRVCD6UpEv7bWApa7anoPg1hU/LHLp3lRjPPjyam
   FRrRnq3Ziv+Blzh6PlkSNSPI7U2gGAXCW+KmkvFvMbW5QdW9xtwVkUDlh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="260081841"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="260081841"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 23:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="570921063"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 06 Apr 2022 23:55:28 -0700
Date:   Thu, 7 Apr 2022 14:48:07 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: Re: [PATCH v3 5/5] fpga: fpga-region: Add missing kernel-doc
  description
Message-ID: <20220407064807.GA256966@yilunxu-OptiPlex-7050>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
 <20220403051641.3867610-6-nava.manne@xilinx.com>
 <20220405053547.GA249845@yilunxu-OptiPlex-7050>
 <SN6PR02MB45766BEFCA6532873271099FC2E69@SN6PR02MB4576.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB45766BEFCA6532873271099FC2E69@SN6PR02MB4576.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 07, 2022 at 05:31:39AM +0000, Nava kishore Manne wrote:
> Hi Yilun,
> 
> 	Thanks for providing the review comments.
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@intel.com>
> > Sent: Tuesday, April 5, 2022 11:06 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; Michal Simek
> > <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> > <git@xilinx.com>
> > Subject: Re: [PATCH v3 5/5] fpga: fpga-region: Add missing kernel-doc
> > description
> > 
> > On Sun, Apr 03, 2022 at 10:46:41AM +0530, Nava kishore Manne wrote:
> > > Fixed the warnings: No description found for return value of 'xxx'
> > 
> > The commit message is not clear. There are descriptions for some functions,
> > but not in right format.
> > 
> I agree for some functions has description but not in the right format.
> The "Description Not exits" and  "Description not in the right format" in both cases the tool will report the same warning ie; " warnings: No description found for return value of 'xxx'"

Thanks for the info. It would be better we describe the root cause in commit
message along with the robot reports.

And also change the subject please.

> This patch address the above warning. So to make it relevant I have added the same in the commit msg.

Adding the same commit message may not be a good way, for this case you could
just combine them into one commit.

Thanks,
Yilun

> 
> Regards,
> Navakishore.
