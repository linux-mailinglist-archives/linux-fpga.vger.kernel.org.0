Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD64C15C8
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Feb 2022 15:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbiBWOuD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Feb 2022 09:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241829AbiBWOt7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Feb 2022 09:49:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA039B716E;
        Wed, 23 Feb 2022 06:49:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85EFF6170C;
        Wed, 23 Feb 2022 14:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403B3C340F3;
        Wed, 23 Feb 2022 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645627755;
        bh=M6i8Ax/c1AB4NHK/oFnPHSNbHeHzsRhTsad/UfRd5wE=;
        h=From:To:Cc:Subject:Date:From;
        b=QLsD3BxRDRD82LHGlm0kF7oI9uupOpfdnttOWlK2+rfGJbUaYESxUlrfJGm9oBlN3
         y5mfVbWSD3KtDzcIq25MbtgWzVbC0pFcK6qWK9QO+1dD6fAl7DV2KX+0bYjnF4SNKi
         PJVIhYSLCic+EIg7H1Obpa69yuq2b//cKOSy4D8x073h1MzKY9qqipJA3lQggiNO43
         6m0R15kC4e/UKRZOk9tjV/nz3KK1tlX/Pv5ZjShtcKdQmxhNq9CZGIpANJ+1D+Ghcm
         jl9WeLUrLm1Zy6Mf80gJJ9Sm3E/DmDaM1M4LpY7SOxVnsR/4QH7+AWVoQdOIw85Wpo
         VEyM3CxBx0TbQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: add a git repo for the Stratix10 Service driver
Date:   Wed, 23 Feb 2022 08:49:07 -0600
Message-Id: <20220223144908.399522-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add a git repo entry for the Stratix10 Service driver.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..5752236bea80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9890,6 +9890,7 @@ F:	drivers/firmware/stratix10-rsu.c
 F:	drivers/firmware/stratix10-svc.c
 F:	include/linux/firmware/intel/stratix10-smc.h
 F:	include/linux/firmware/intel/stratix10-svc-client.h
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
 
 INTEL TELEMETRY DRIVER
 M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
-- 
2.25.1

