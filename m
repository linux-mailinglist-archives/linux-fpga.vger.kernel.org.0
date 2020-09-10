Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274C1263BA4
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Sep 2020 05:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIJDxk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Sep 2020 23:53:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:63045 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIJDxa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Sep 2020 23:53:30 -0400
IronPort-SDR: 8h/wURbms3yqbthoS0URkKUmr9lnhgUdrzcjd/I8PU64qN+upRiDAsw6U7TMJ7LrZ//18NoeCn
 NE7QbzBH6Seg==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="243281260"
X-IronPort-AV: E=Sophos;i="5.76,411,1592895600"; 
   d="scan'208";a="243281260"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 20:53:22 -0700
IronPort-SDR: 2C2Qn0KIzD//fxE2BOxjBhycDNhnvBbKkYKTe/AzFKeT3xTVq/5VicZrqGulGq0omWnnCdgONW
 DVi4ibfZ7Olg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,411,1592895600"; 
   d="scan'208";a="449443228"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 09 Sep 2020 20:53:20 -0700
Date:   Thu, 10 Sep 2020 11:49:04 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v8 1/2] fpga: dfl: create a dfl bus type to support DFL
  devices
Message-ID: <20200910034904.GA20920@yilunxu-OptiPlex-7050>
References: <1599488593-16433-1-git-send-email-yilun.xu@intel.com>
 <20200910033217.GA3003@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910033217.GA3003@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > 
> Applied to for-next,
> 
> (I added the Documentation/ABI/testing...) file to MAINTAINERS.
> 
> Please run checkpatch next time.

Thanks for your fix. I run the checkpatch but I do ignored the
warning about MAINTAINERS. I'll take care of it then.

Thanks,
Yilun

> 
> Cheers,
> Moritz
