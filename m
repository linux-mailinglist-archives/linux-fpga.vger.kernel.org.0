Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2702F6D35D6
	for <lists+linux-fpga@lfdr.de>; Sun,  2 Apr 2023 08:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjDBGrt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 2 Apr 2023 02:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBGrt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 2 Apr 2023 02:47:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8D81882D;
        Sat,  1 Apr 2023 23:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680418068; x=1711954068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ILD5aDX4xRvk1GomwpsChYpGWYmYGxotq3yjh2CxP9E=;
  b=Un53VBcktewywafeNbNX0poDZ6J/sEuEecQcjpVwlMoW7Roa/XidHQX1
   u1umG/zUJgtPnAE1Zy+jSnL+Ppib4i5vGA26SE+uEaJkj4Lh5vf+Er5sC
   kDGq3D7hjLlnIYj0hyDHr/XEXDZDii9T7vW4zjtpugHruCbO+TS1djIWO
   lLI7PzUOSlHwB/MJ0p4fW6qxnfd3lrXfNJ7ZzJy3VawlwFV35Kx9YAMBu
   I3w1imjDsVU3j3hpAnNEnzNYkYY2l70Zj4gH3d2VGnPcNEGH2SCnTcuxa
   PmgDsLHApb5NaR/F9NT0muoPo2jZnmh74Oleg+5BRB220wDv7EoSx/6os
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="325706286"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="325706286"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 23:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="662839893"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="662839893"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2023 23:47:45 -0700
Date:   Sun, 2 Apr 2023 14:36:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: bridge: fix kernel-doc
Message-ID: <ZCkiWfQQsFEaHm4K@yilunxu-OptiPlex-7050>
References: <20230330174505.158920-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330174505.158920-1-marpagan@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-30 at 19:45:05 +0200, Marco Pagani wrote:
> Fix the following warnings issued by the kernel-doc script:
> 
> drivers/fpga/fpga-bridge.c:99: warning: No description found for return value of 'of_fpga_bridge_get'
> drivers/fpga/fpga-bridge.c:163: warning: No description found for return value of 'fpga_bridges_enable'
> drivers/fpga/fpga-bridge.c:187: warning: No description found for return value of 'fpga_bridges_disable'
> drivers/fpga/fpga-bridge.c:238: warning: No description found for return value of 'of_fpga_bridge_get_to_list'
> drivers/fpga/fpga-bridge.c:268: warning: No description found for return value of 'fpga_bridge_get_to_list'

I see you are trying to clean up the warnings, but I found more in
drivers/fpga. Could you help at least fix all core code,
(of-)fpga-bridge/region/mgr.c/h in series? Thanks.

> 
> The patch is based on top of 38dbcd697770 ("fpga: bridge: fix kernel-doc parameter description").

I didn't found this commit, could you elaborate? And you could put this
info in changelog, don't show it up in mainline.

Thanks,
Yilun
