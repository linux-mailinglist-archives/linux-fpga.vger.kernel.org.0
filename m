Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407F66E438D
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Apr 2023 11:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDQJTr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Apr 2023 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDQJTl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 17 Apr 2023 05:19:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E883A94;
        Mon, 17 Apr 2023 02:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681723179; x=1713259179;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/rpXO8UEDEXcx2JhVMtmPjL+LYqlQvN0uFZLRWaYDYI=;
  b=lprArSlp/6jGCVG+lKR+qh3zWjfMIC7vyP5emefG3BQOlxO9eg3/KlD/
   XTn6OGfT2hcqcLfmJ0cDQVHTPN41cWfBYNcIdVXXUq/S4tBqdw/3xXYaj
   tkyGq/6zz2JEJCHh/ka09oT0KY/ytT57rm4lw5838H5FMKbTp+0fqtZLf
   r+4jjHXBeTbJt+cbPi2S2sORNZdjBiTY9ens+V9kGkndeVCImamU6RDTM
   ah1mHkKmzfX8+xKy+ioVnYzXBN5GICRUjpIc2Q/SdO5LL1dyp2yezsLZF
   xvDYytPRnaIP6SU5Wdw89xN2tHtL4K7+mwRzDCc0YGU8gZIViJfgpx5m+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="410058060"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="410058060"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="864940320"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="864940320"
Received: from anicosix-mobl2.ger.corp.intel.com ([10.249.35.34])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:19:35 -0700
Date:   Mon, 17 Apr 2023 12:19:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] intel-m10-bmc: Manage register access to control
 delay during sec update
In-Reply-To: <20230417091619.14134-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <53d2d5eb-26e-d017-41cc-60292a6f33a6@linux.intel.com>
References: <20230417091619.14134-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1535459921-1681723178=:2047"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1535459921-1681723178=:2047
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 17 Apr 2023, Ilpo Järvinen wrote:

> Manage handshake register access on Max 10 FPGA cards that have a major
> slowdown on reading handshake registers during secure update prepare and
> write phases. The problem does not occur with PMCI-based cards.
> 
> The first patch which moves Max M10 symbols into own namespace is
> otherwise independent of the other changes but it would conflict with
> this series if sent as separate change. Thus, it's part of this series
> to give the patches a well-defined order.
> 
> Ilpo Järvinen (4):
>   mfd: intel-m10-bmc: Move core symbols to own namespace
>   mfd: intel-m10-bmc: Create m10bmc_sys_update_bits()
>   mfd: intel-m10-bmc: Move m10bmc_sys_read() away from header
>   mfd: intel-m10-bmc: Manage access to MAX 10 fw handshake registers
> 
>  drivers/fpga/intel-m10-bmc-sec-update.c | 47 +++++++------
>  drivers/hwmon/intel-m10-bmc-hwmon.c     |  1 +
>  drivers/mfd/intel-m10-bmc-core.c        | 90 ++++++++++++++++++++++++-
>  drivers/mfd/intel-m10-bmc-pmci.c        |  1 +
>  drivers/mfd/intel-m10-bmc-spi.c         | 15 +++++
>  include/linux/mfd/intel-m10-bmc.h       | 43 ++++++++----
>  6 files changed, 163 insertions(+), 34 deletions(-)
> 
> 

Please disregard v2. I'll send v3 shortly. 

(I managed to add the tags into wrong files so they're not correctly 
here in v2).

-- 
 i.

--8323329-1535459921-1681723178=:2047--
