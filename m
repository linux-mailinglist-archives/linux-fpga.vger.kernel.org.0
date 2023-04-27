Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334776F07F2
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Apr 2023 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbjD0PHU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Apr 2023 11:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjD0PHT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 27 Apr 2023 11:07:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C513E2726;
        Thu, 27 Apr 2023 08:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC5863925;
        Thu, 27 Apr 2023 15:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD476C433EF;
        Thu, 27 Apr 2023 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682608037;
        bh=ulSYfIm/Xn1w4SJK9Tdg8qvteSnavwAKqwgP2KV+nys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umA7rf5axnH/KTHkq7Hwa3KkLBl3zqEU7DEZDeAXcN4AZH2EwTAknJBGiEXKNtrt2
         XCHQgb12tgqSsvatcrAKwzk31ZjJFdGE52gvi9S60biI7W9rLaKRdY4+gBdlJaJ8Yh
         /8lTpFPM9InRu6rGXIucZt76eljc4CBzmscmAh1oVfcCzZjAPnhjswRvkoMs6fiRHk
         ch9hqCBqneRsL7kSoMfgKkheUOvmLekJg36aPeQtadfceexHSIsyIUNM3g52gIr6Jt
         5M8zBz68Sega5dcSGOF1ZRfj5LpRZgoZyD+5IYdxClRala8UNhiis4mzx5jvsLn06G
         mkCyJMu3K7tyw==
Date:   Thu, 27 Apr 2023 16:07:12 +0100
From:   Lee Jones <lee@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mfd: intel-m10-bmc: Manage access to MAX 10 fw
 handshake registers
Message-ID: <20230427150712.GV50521@google.com>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417092653.16487-5-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 17 Apr 2023, Ilpo Järvinen wrote:

> On some MAX 10 cards, the BMC firmware is not available to service
> handshake registers during secure update erase and write phases at
> normal speeds. This problem affects at least hwmon driver. When the MAX
> 10 hwmon driver tries to read the sensor values during a secure update,
> the reads are slowed down (e.g., reading all D5005 sensors takes ~24s
> which is magnitudes worse than the normal <0.02s).
> 
> Manage access to the handshake registers using a rw semaphore and a FW
> state variable to prevent accesses during those secure update phases
> and return -EBUSY instead.
> 
> If handshake_sys_reg_nranges == 0, don't update bwcfw_state as it is not
> used. This avoids the locking cost.
> 
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Co-developed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 17 +++++--
>  drivers/mfd/intel-m10-bmc-core.c        | 67 ++++++++++++++++++++++++-
>  drivers/mfd/intel-m10-bmc-spi.c         | 14 ++++++
>  include/linux/mfd/intel-m10-bmc.h       | 28 +++++++++++
>  4 files changed, 121 insertions(+), 5 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
