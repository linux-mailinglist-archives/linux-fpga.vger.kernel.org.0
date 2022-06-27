Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A88355D446
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Jun 2022 15:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiF0HqI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Jun 2022 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiF0HqH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Jun 2022 03:46:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDAA60E8;
        Mon, 27 Jun 2022 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656315966; x=1687851966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ur+/pIlVDwcPx+vLoZ2vqwsNPyXivHFAV4ACXjab44=;
  b=egN2nWFwNZWqR0fAEXFzvB0t/XEuFgva4VdR3EDiLyKURTqy/9CHRTfZ
   c2ii6whC6asgttmMP/I7kdXQn4K555bTlpQMtMXA3zwWhTDIR3A4wdpng
   e6XqypHAkiAjoBwcNx3FyvOzu5WrJ0TgentaTUmYSdP9cMMJtv307F9Tb
   G+5S4X0wvs5EGc+4FY3YbnUY7hEGbxIOZTr9/jeRCU7QWKEKF4zJS3/sJ
   f/fN76q1C9mNJv1RJj8YT0AJWksOpf5doiEHBy+v1wVPsuUoJIUYmwwpM
   SOHm19e9s4pnPrh2ZgFnxxZr+28yVez1VIh7XgxSEpSXrkXQHwbN1oUrk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="280148114"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="280148114"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 00:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="836088244"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2022 00:46:04 -0700
From:   tien.sung.ang@intel.com
To:     yilun.xu@intel.com
Cc:     christophe.jaillet@wanadoo.fr, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, tien.sung.ang@intel.com, trix@redhat.com
Subject: Re: [PATCH v2] fpga: altera-cvp: Truncated bitstream error support
Date:   Mon, 27 Jun 2022 15:45:53 +0800
Message-Id: <20220627074553.3136597-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608103058.GG481269@yilunxu-OptiPlex-7050>
References: <20220608103058.GG481269@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > Though without doubt, your solution is doable, I have a 
> > discussion with the Intel architect and they insisted that
> > the device driver must not make such a decision. The decision to 
> > drop or accept a transfer is up to the firmware. The firmware

> Why dropping or accepting is forbidden, but padding is allowed? If the
> decision is no operation to the data, then padding should also be
> forbidden.

> > insisted that the buffer be padded with whatever value. They

> If I understand right, the 2 decisions are conflicted. On one hand,
> the driver should not care about the data. On another hand, the
> driver should still care about the data for some rule.

> So please firstly reach your agreement before making patches.

Had some delays in replying,from the perspective of the driver, 
Intel architects want it to be just purely on the transfer of 
data without inspecting the data. 
If the size of a transfer is 4096bytes, we can padd it. 
I can do that which I think it is not an issue.
Let me create a reworked patch to pad the payload with Zeros.
Would this be OK for patch v3?

> > Yes, it could look confusing to other programmers. And, yes, the 
> > padding doesn't matter. Let me relook into this. As the driver is 
> > already re-tested by the silicon validatioin. 
> > I want to avoid making any change as it
> > would meant another couple of weeks of re-testing. 
> > Can this be accepted as it is?

> Sorry, I can't. Some clarification is needed.

Reply as above, let us implement the padding in the
next patch v3. Appreciate your inputs. Thanks
