Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581C641869F
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Sep 2021 07:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhIZFxN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 26 Sep 2021 01:53:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:20119 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhIZFxN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 26 Sep 2021 01:53:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="203810302"
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; 
   d="scan'208";a="203810302"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2021 22:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; 
   d="scan'208";a="552367749"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Sep 2021 22:51:36 -0700
Date:   Sun, 26 Sep 2021 13:44:49 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org,
        hao.wu@intel.com
Subject: Re: Maintenance of Linux FPGA
Message-ID: <20210926054449.GD806603@yilunxu-OptiPlex-7050>
References: <YU9s27qwyzmeONiq@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU9s27qwyzmeONiq@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Sep 25, 2021 at 11:39:23AM -0700, Moritz Fischer wrote:
> Hi all,
> 
> I lately did not have enough time to dedicate to the Linux FPGA
> subsystem, concerns were raised around bus-factor and all.
> 
> Looking at my day-job I don't see this getting better in the short-term
> so I've decided to get a conversation going on how to structure this
> better for the benefit of the Linux FPGA subsystem.
> 
> Maybe a maintainer team approach would address the bus factor and
> workload concerns better?
> 
> In terms of people I was thinking about:
> 
> Hao has done a great job at keeping the DFL part of things going, so I
> think he'd be a great choice.
> 
> Yilun has been very helpful with reviews and I think he'd be a good
> pick, too.

It's my pleasure for the nomination and yes I'd like to be one of the
maintainer team, to be more helpful.

Thanks,
Yilun

> 
> In terms of how to structure this: I'm not sure just yet, open to input.
> 
> How do other multi-maintainer subsystems operate? Ideas? Suggestions?
> 
> Let me know what you think,
> 
> Moritz
