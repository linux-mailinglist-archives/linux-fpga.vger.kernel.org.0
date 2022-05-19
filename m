Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0252CAD7
	for <lists+linux-fpga@lfdr.de>; Thu, 19 May 2022 06:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiESEWo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 May 2022 00:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiESEWm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 May 2022 00:22:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D571054F;
        Wed, 18 May 2022 21:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652934162; x=1684470162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t76k+55CvsHktO8F2+yZT/MW2C/RlykP0eSZCo+OnJk=;
  b=Lp89bWC6tfb9dx93xJXUl2yoPYqpRgv9tHPUX5Jwu90COzH79tGcv8ot
   b8fPG7W+t2fegOOi+FGcWaPlSFYq20tfwCumioWza0/aovW8b6dZJDx77
   01fUjxGquSztp04pvFTgVncG8i2v4E5Lfva6RpbAKAK4F3gQbXDAHk67c
   OOUpLjTFLQkVXc4xnj3Q/aHPEF7buG829ixabAQmYuBUrGRBeIJE+Zy+D
   FdTtDWHOgRyP7C3dBAyN8cOkACopis7SRQvyQlSoTdEV0OT6H4oJA1Q6M
   q17Xu6AHdVf009FH35fRmGS0BrmrRCOT/NWFjiJc4FGdQ92nvzDJ9VPWx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="332629317"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="332629317"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 21:22:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="700960357"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2022 21:22:39 -0700
From:   tien.sung.ang@intel.com
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        tien.sung.ang@intel.com
Subject: Re: [PATCH] fpga: altera-cvp: Truncated bitstream error support
Date:   Thu, 19 May 2022 12:21:35 +0800
Message-Id: <20220519042135.2805176-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6939d35f-36a0-568e-bfec-4dd2e3a48604@wanadoo.fr>
References: <6939d35f-36a0-568e-bfec-4dd2e3a48604@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Thanks for pointing that out. It is always good to get all the alignments right.
I will add this to the next revision of the patch.
