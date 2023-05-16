Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E60C7044FA
	for <lists+linux-fpga@lfdr.de>; Tue, 16 May 2023 08:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjEPGFT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 May 2023 02:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEPGFT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 May 2023 02:05:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73243189;
        Mon, 15 May 2023 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684217118; x=1715753118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iFSzgYi4YXQ6RMkZWtTXy50InoOVuhmgPI/fa4+vyHk=;
  b=NdOWRtJFRKjM7gzbdka8kXlekopcBXyQLI1xEqi4lCB+RoxBdZdAKnSD
   cLinIF1kkjtrME1/d1Y6UJSIlMBuztYVJ8nCktp79dzQsiwBmiVMeC+FL
   t6eHSUkx0R2IPrxyzfHd3/AgxZm8h9ATKTqN/R0d/4Grg+q+n3XMCK8+r
   ai+vpsL/T7tfLW03F6qcGU1UnEp/bln9J1g/616fGbyE5R7Bhe4d8wOrL
   s5qoimxcj2C9QXPWxQHNjr45HvGwmt4II5fTr0JuvjED7gb0411i+0LqZ
   rl+6DryMAep1UngHc68cbLb5j9SSnDfJgItKtu+3XjJi6EpSTc+jMK+Yk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="340756883"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="340756883"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 23:05:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="947712122"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="947712122"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 15 May 2023 23:05:09 -0700
Date:   Tue, 16 May 2023 22:05:04 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Documentation: use capitalization for chapters and
 acronyms
Message-ID: <ZGONkPmwznEMPXM1@yilunxu-OptiPlex-7050>
References: <20230516001518.14514-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516001518.14514-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-15 at 17:15:18 -0700, Randy Dunlap wrote:
> Use capital letters in acronyms for CD-ROM, FPGA, and PCMCIA.
> 
> Use capital letter in the first word of chapter headings for
> Locking, Timers, and "Brief tutorial on CRC computation".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-fpga@vger.kernel.org
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  Documentation/cdrom/index.rst   |    6 +++---
>  Documentation/fpga/index.rst    |    2 +-
>  Documentation/locking/index.rst |    2 +-
>  Documentation/pcmcia/index.rst  |    2 +-
>  Documentation/staging/crc32.rst |    2 +-
>  Documentation/timers/index.rst  |    2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> --- linux-next-20230515.orig/Documentation/cdrom/index.rst
> +++ linux-next-20230515/Documentation/cdrom/index.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -=====
> -cdrom
> -=====
> +======
> +CD-ROM
> +======
>  
>  .. toctree::
>      :maxdepth: 1
> --- linux-next-20230515.orig/Documentation/fpga/index.rst
> +++ linux-next-20230515/Documentation/fpga/index.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  ====
> -fpga
> +FPGA
>  ====

For FPGA part,

Acked-by: Xu Yilun <yilun.xu@intel.com>

Thanks
