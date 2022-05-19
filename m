Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40352CF92
	for <lists+linux-fpga@lfdr.de>; Thu, 19 May 2022 11:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiESJjj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 May 2022 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiESJjf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 May 2022 05:39:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5176793A1;
        Thu, 19 May 2022 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652953173; x=1684489173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zz/XtCzs4Jz68O9hElJ+yP5O0TaZacOcZONwGmR20F0=;
  b=LWNjI2+47LoyYiaJP1bVKp7iy5CMCk6ywUHywCzq3U0xiMNuNCxP3mUv
   s/MvfapVMPTKXDP0niC6iIIXhc35UjDMnLJb3xI/T+2KV/aBAlLHNBIJl
   kx+5kE/UjztMJCvMTB/Wb8+iMlhf8XWFUzHfnE2yFAKjXxLcOdQEGawAS
   HxdgCYdQDPUV2M9SO15Hm2v8HCiJGy8kjeOgBQD0PM6dLKNKX8vyi5j9G
   DiVOjzbb56LCaoeYjQ6trS7UyBGj3YmlWgiaKVNlfwfxZYTYFDpXy9i9L
   e4ktK3a6o8khmBJ60UvNxMauwOU6c3GMi2eMvOk2cGcpPPLhP5lSf45MP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259693819"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259693819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 02:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="817893177"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by fmsmga006.fm.intel.com with ESMTP; 19 May 2022 02:39:31 -0700
From:   tien.sung.ang@intel.com
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        tien.sung.ang@intel.com
Subject: Re: [PATCH] fpga: altera-cvp: Truncated bitstream error support
Date:   Thu, 19 May 2022 17:39:07 +0800
Message-Id: <20220519093907.2883394-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b0fd6c41-f8a4-bb3a-d05a-2ea17d4ffc80@redhat.com>
References: <b0fd6c41-f8a4-bb3a-d05a-2ea17d4ffc80@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Thanks for bringing this up. Yes, you are right that the fpga_mgr sees this
as an error irrespective of the value. The CvP driver is changed now to just
indicate the correct error which recommends a retry. To me understanding,
EAGAIN was this. The fpga manager now looks like is going to return a CvP
failure in short. 
A BUSY state does not seem to be able to solve this issue. 
Even an extended time-out didn't resolve this error state. The current time-out
is set to 10seconds.   
However, the main objective is to also handle the error if the CvP firmware
is not responsive. The error_path flow is to reset the CVP mode and HIP_CLK_SEL bit
as recommended by the firmware engineers. 
The flow prescribed here is also an identical copy of working CvP driver 
which is also owned by Intel. This driver is a downstream driver which is 
not part of the Linux kernel. We are now porting this differences over to 
the current upstream CvP driver. 
