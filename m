Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3189D52CB25
	for <lists+linux-fpga@lfdr.de>; Thu, 19 May 2022 06:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiESEee (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 May 2022 00:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiESEed (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 May 2022 00:34:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86744C1EEF;
        Wed, 18 May 2022 21:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652934872; x=1684470872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6H7Y0vRICaaXnBsjuel9L4ADqlH4Ymet5HLS2FGL6V8=;
  b=TEBCCbVDMxxdJlJbnkDgg8Cmzb9KG7+CQu2Dp22yY3Ygddu1cCOFp1Wr
   IJN0wSv6cGdRF2vcCbj+mYgq3oKE/9X5SF7g0lQCxHk7EpNJNATzy/HD5
   0CnXqpqKenZuL9OKwe0tXTryjimKJLpxELtt9id/v7qmJKDX+sFx6Rpzg
   501voPu3OP/aDPO4aoEF6dJrlUlnmbg0lo9yI83q2m5Meb1rw5N7zGrRU
   3w/lezX/+cZverWVC3ghHO52g7Z1A7OlcNPXGfBxRpilVGlmS5x1PGoBn
   NpP9WNEcxZITLRLtpLDt0c5rMnkVGExoP8AfUkfQDd7W7QGWg/NMzRl2E
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259584030"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="259584030"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 21:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="742709968"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga005.jf.intel.com with ESMTP; 18 May 2022 21:34:29 -0700
From:   tien.sung.ang@intel.com
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        tien.sung.ang@intel.com
Subject: Re: [PATCH] fpga: altera-cvp: Truncated bitstream error support
Date:   Thu, 19 May 2022 12:34:12 +0800
Message-Id: <20220519043412.2805706-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3911c8c7-da6d-e6f2-c747-3b601d9cdacc@redhat.com>
References: <3911c8c7-da6d-e6f2-c747-3b601d9cdacc@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The send_buf is always used throughout the life-span of the CvP driver.
Hence, we thought it would be wise to just pre-allocate it one time
at the start of the probe/init.
It is also fine if we do it in the altera_cvp_write. The only issue we
see in this is that, a minor hit on the performance as you need to 
then, allocate the buffer on every new CvP FPGA configuration write.

As for STEP 16, the previous implementation checks the Error latch bit
which stores the previous transaction's result. If an error occurs
prior to this, the driver would throw an error which is not right.
The correct step is to just check for the current CvP error status 
from the register.
Hope that is fine with you. Thanks
