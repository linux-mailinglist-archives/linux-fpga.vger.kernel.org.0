Return-Path: <linux-fpga+bounces-156-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1484583AD2E
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jan 2024 16:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7040281421
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jan 2024 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094177656;
	Wed, 24 Jan 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBCFQQWu"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF317C67
	for <linux-fpga@vger.kernel.org>; Wed, 24 Jan 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109880; cv=none; b=Vk32OSCNbN5JHvA9hJcJPCyjUpFoWKCPPHMj1mn2Is65lB/QrnKXC4e0nsyW7v4WssLUShyjE+ZXfY49JyK8sqJ9ruV/VKSddJaCbrokJ4BlvMsUdcr/F3sH3vULjQig9N/akOPStVu9XB14mbzY6iSmuJh39/j/xGWd3a9fDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109880; c=relaxed/simple;
	bh=TIoLI0NOg9IhGkDnZ07u3QedeQaS0I76rjo0TfaQbW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNc6Orrl14Hkw05gpKre/3M/Bn+OVEIx05O9jU+xa2bC7ggE5GUIm1lXy+tNCSso6D2ViZGzmKm6AmyN+17eKiM4bGdgdCTxvsNtYHUyLvgH+LyoxqqlICwWFl1k8TLzCQFLuOJa3K+aKoDN/+iCLL7L0Df3FnigSWLjmyn2gKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBCFQQWu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706109877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+IWdzfKReTN2PlVowzK8vMbbI1VNfdZNNhWBnWl7Hmk=;
	b=hBCFQQWuMf48OjUr1SSOpkR/4xOwyGp15CJ6XlNsq60j5Id7FbQasL9Q63Cws59gAVKihp
	u8gtbzKsoqbnoCGFW6ZKYqFjnmKkJCsFjrvFsYolhQ5NfCHC2WHIGiisdHhFAKYrhzetwC
	GNaXC/nenrYGnYA3T4g3UULy3nuPQbg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-kE-1Dyn5NSKhrxKYF63HWA-1; Wed, 24 Jan 2024 10:24:36 -0500
X-MC-Unique: kE-1Dyn5NSKhrxKYF63HWA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-781720619f9so858741985a.1
        for <linux-fpga@vger.kernel.org>; Wed, 24 Jan 2024 07:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706109875; x=1706714675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IWdzfKReTN2PlVowzK8vMbbI1VNfdZNNhWBnWl7Hmk=;
        b=WOhmeRKsJtodgT1hu1mi90s/lVXAUOa+iFj2RfntqnllbRVxLUxOMSb3W9KBSw9XjS
         hjSuWDOmYL7vpIBZyVPyxQFXe5inPcaW7LYu3pzD1NUzQ1uXsIdsjgjbEq1hHiq+lae1
         jNcWKiEoutwmtykM+eYriv2/N82AP1iz0JW1BMArQN9grxYSrMozIlbdrv6yZtopVUJe
         L8OL7z/sjFHlTuZV3j5sMO2Y0kh26i3TOKWhGllymXwd5wMSWru9cDQWBxanqSDzLlCx
         tdfuivgJGuxckHml5Fzkib7Wj2G50tiNiINJlMjVTiiwod5tSUK6Hbd1IxnZhQAgyh4M
         ifNg==
X-Gm-Message-State: AOJu0YyTFwpHvG6rIncIKAib52nVZ6fw+qgx0n6Cswn91HW/rj+Lkcyl
	4cZCVI37HzMVhBP/MZ0YEkRu9+H0LUWls0LZtDMtctEpnOFwEnbXITQvDzeYaHVyR7EUKyxqfB2
	lwn/p/FHa4P47UD6bGp25VonOoo0/bxCflipCfEMTtZROXHJib29342RhbWhuLG8Isw==
X-Received: by 2002:a05:620a:b09:b0:781:4d22:da3 with SMTP id t9-20020a05620a0b0900b007814d220da3mr8139810qkg.138.1706109875716;
        Wed, 24 Jan 2024 07:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2BfiDB5CsRVcuehc5tORKDkuTL/4NqMavF8HAKOEJDcAoQ4Tj24hFb/oste1KOxPQfa0OQQ==
X-Received: by 2002:a05:620a:b09:b0:781:4d22:da3 with SMTP id t9-20020a05620a0b0900b007814d220da3mr8139801qkg.138.1706109875523;
        Wed, 24 Jan 2024 07:24:35 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id pa15-20020a05620a830f00b007815b84dbb3sm4126401qkn.49.2024.01.24.07.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:24:35 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: remove redundant checks for bridge ops
Date: Wed, 24 Jan 2024 16:24:07 +0100
Message-ID: <20240124152408.88068-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class
driver") introduced a check in fpga_bridge_register() that prevents
registering a bridge without ops, making checking on every call
redundant.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index a024be2b84e2..e0a5ef318f5e 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -30,7 +30,7 @@ int fpga_bridge_enable(struct fpga_bridge *bridge)
 {
 	dev_dbg(&bridge->dev, "enable\n");
 
-	if (bridge->br_ops && bridge->br_ops->enable_set)
+	if (bridge->br_ops->enable_set)
 		return bridge->br_ops->enable_set(bridge, 1);
 
 	return 0;
@@ -48,7 +48,7 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
 {
 	dev_dbg(&bridge->dev, "disable\n");
 
-	if (bridge->br_ops && bridge->br_ops->enable_set)
+	if (bridge->br_ops->enable_set)
 		return bridge->br_ops->enable_set(bridge, 0);
 
 	return 0;
@@ -401,7 +401,7 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
 	 * If the low level driver provides a method for putting bridge into
 	 * a desired state upon unregister, do it.
 	 */
-	if (bridge->br_ops && bridge->br_ops->fpga_bridge_remove)
+	if (bridge->br_ops->fpga_bridge_remove)
 		bridge->br_ops->fpga_bridge_remove(bridge);
 
 	device_unregister(&bridge->dev);

base-commit: c849ecb2ae8413f86c84627cb0af06dffce4e215
-- 
2.43.0


