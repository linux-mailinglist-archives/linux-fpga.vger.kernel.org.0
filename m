Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE06522F54
	for <lists+linux-fpga@lfdr.de>; Wed, 11 May 2022 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiEKJXu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 11 May 2022 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiEKJXs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 11 May 2022 05:23:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C247A826;
        Wed, 11 May 2022 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652261027; x=1683797027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u6yh7Cvn3xBGfrM5loS9SQLU9qTOgpc2tg+3GitS5t8=;
  b=R+VgVMidwpWyJapmpOPFWRm+UKIXN9S2H3D9Q9cpA52t+U7CDK/6l601
   JAv2n50XlySFGVtmTphvv3uMG9fxj3zocVJIMVVyX+HgSJi0ngaoLfhMZ
   A/6i/IDoYIJjvUAbkblpEu3B4iLCJldNJ+IkdamGzWzaLN3pxXedyj/3I
   MkCHlobFwSFxnzXr9nnH7e1IrlpFzDzPMQJ5PUXOeSWbz5j4gauUZS5fc
   tOFOUPwKqw4hv7gOXvnC/4wqtfnheggD+MfkW/dwVLmXyllcWgjICBxrt
   SzZDw1m+Kkmy5pl0V+NXq8QeraD/3InAfhHKgTfFkUIr7yw0dJkDkOhho
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="257186975"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="257186975"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 02:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="520443318"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga003.jf.intel.com with ESMTP; 11 May 2022 02:23:37 -0700
Date:   Wed, 11 May 2022 17:15:39 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Wu Hao <hao.wu@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Message-ID: <20220511091539.GB487046@yilunxu-OptiPlex-7050>
References: <YnkE8AbimDa7sfN8@kili>
 <20220509170015.GC470015@yilunxu-OptiPlex-7050>
 <20220511083329.GN4031@kadam>
 <20220511084838.GA487393@yilunxu-OptiPlex-7050>
 <20220511091718.GQ4031@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511091718.GQ4031@kadam>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, May 11, 2022 at 12:17:18PM +0300, Dan Carpenter wrote:
> On Wed, May 11, 2022 at 04:48:38PM +0800, Xu Yilun wrote:
> > On Wed, May 11, 2022 at 11:33:29AM +0300, Dan Carpenter wrote:
> > > On Tue, May 10, 2022 at 01:00:15AM +0800, Xu Yilun wrote:
> > > > 
> > > > Hi Dan & Moritz:
> > > > 
> > > > Thanks for the patch. But it actually reverts Nava's patch. Since Nava's
> > > > patch is not pushed to linux-next yet, could we just drop it from
> > > > linux-fpga?
> > > 
> > > I don't know if you meant linux-next.  It's pushed to linux-next.  But
> > > linux-next is rebased every day so reverting is fine as far as linux-next
> > > goes.
> > 
> > Thanks for the info. I was not aware of that and may mess up something.
> > I force pushed the linux-fpga yesterday for this patchset, then linux-next
> > would be conflict with linux-fpga, is it?
> > 
> > If it is the case, how could I remedy?
> 
> No.  Don't worry about linux-next.  Stephen rebuilds it from scratch
> every day.  It's fine if you rebase.  There are quite a few trees which
> rebase.

That's good new! Thanks again.

> 
> regards,
> dan carpenter
