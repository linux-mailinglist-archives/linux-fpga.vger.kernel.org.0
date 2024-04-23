Return-Path: <linux-fpga+bounces-516-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6DF8AF3CE
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Apr 2024 18:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DA52869B6
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Apr 2024 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B213D250;
	Tue, 23 Apr 2024 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMenr3ch"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6813CA99
	for <linux-fpga@vger.kernel.org>; Tue, 23 Apr 2024 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889369; cv=none; b=Y+s9swgpd9p3w2Zgeg1QVJwvQg5VVFUWXu3QQIkYSX1pWQwjPu5P6jhirerMBd7DPGpzzfFv1Oarxl7x7mtSFtIJYGi7HI2lCv954fbrXZhI6EzW8lGGZ4hYxgfX2JXJBIjSuoCaBJem+ZW+gNJboJ37KYYBXAJN0UrY8OBJhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889369; c=relaxed/simple;
	bh=RZ9HqBGp7TiesVGMtiKF6isf7pQuV7LId4hRp1mxlRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTY5itXAKv7/Xrib8onuSL8Yj4APs93JVCtF9zOkBLXsu8PPE8JSjFQwA+QT4/VM6yiE2nirEKAQtCljWee61luOoi81zPlD0W5Ek+9/WaDWyqEm+dTT6sbHfT0DSBKJ4rgWtNaRPu7Druh3Bp086sOjAI8J//ZOcIVMUBJFvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMenr3ch; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713889367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H3SCZLnRvL1eBDiJGajTRcdGyi465jDJW6Y0DciZF9U=;
	b=NMenr3chUDTi0gvmzguCKq7UtSkQjcKxlgBK8c8VHaxjtFTseZMICz/2hTXAMtQ/fWp12h
	jptBF18ugBm6ZMw0Uw021ku3R+aJnuR7cSgCLNHneF+DTqCd9QRgTKVSHYOMk1ggf7aI2m
	6VuSJfsfwjGfMWXX9VHb+JXoUwaGrEk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-CVBpU0BWPo6SI3sZpveySw-1; Tue, 23 Apr 2024 12:22:45 -0400
X-MC-Unique: CVBpU0BWPo6SI3sZpveySw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78ef211b746so853716985a.0
        for <linux-fpga@vger.kernel.org>; Tue, 23 Apr 2024 09:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889365; x=1714494165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3SCZLnRvL1eBDiJGajTRcdGyi465jDJW6Y0DciZF9U=;
        b=fjt/Vshs5ap2wUS3sjsGLC4zCXEBdXzPWwqUZZX6M1d18iEnM3SczJBM7A+SRFKJ0T
         4CM/fLLUasl6SLmjOdkmlfa0Zsa7GE3m0xDJE6bVISZQ3ssFLQb0yDfsxMDplcsv0DPu
         MvpxgxUtwD35WYvuqiA8U5s8x48peZkiexGdn4rHb8xAae9ojVo0zcT6xx+rHjKsiHn7
         WT/gKX/3LpFIBJHkhNN5M8/AuRz66os2hnmo6dsykMWCYVookhQOQgGlXMySNyfxH2jO
         upWCCGQuB+TSwC8TUphhvKwYXpvyaEo4IUIaYfcFiwu6VISSNe1rZdvjLpIGfuASJSX9
         9swg==
X-Forwarded-Encrypted: i=1; AJvYcCU3knNjpLSqVOjjB/DsT/g1guWROwG/5JZQFFMvacarSDjUrlNIN1l/ahZNsaguONhPuetpVTdOMEss/TGuQsA58n+QF1Avxuz6sw==
X-Gm-Message-State: AOJu0Yzom97dhS6FEJR8riHzMxkjlJW66meGw811Us91hqyF71Wvlq1E
	aarSXK0Ky3Yc2HdTwm8QZ7SA3gQCWbHIeHVTqFf99hLEEbG8kQfedGURxizIbnEe/tiTfgG+SL1
	QaJ3Sx7L8LNClkqLb6J4FkwGXYdUAiVNj7R1UHoyErTi1xmVYCyj/G7+iAg==
X-Received: by 2002:a05:620a:4c5:b0:790:652b:6ed6 with SMTP id 5-20020a05620a04c500b00790652b6ed6mr11916152qks.35.1713889365078;
        Tue, 23 Apr 2024 09:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6LfYBiqs0o5HuFdrqThiCJq0HcpbT83enbtYOCy34DyyB4s1voP9KXTHqq36y4sCHWLaHbg==
X-Received: by 2002:a05:620a:4c5:b0:790:652b:6ed6 with SMTP id 5-20020a05620a04c500b00790652b6ed6mr11916132qks.35.1713889364776;
        Tue, 23 Apr 2024 09:22:44 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-26-208.cust.vodafonedsl.it. [2.34.26.208])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a066400b0078d73685803sm5412757qkh.99.2024.04.23.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 09:22:44 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: re-enable KUnit test suites for the subsystem
Date: Tue, 23 Apr 2024 18:22:29 +0200
Message-ID: <20240423162229.52023-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The core components no longer assume that low-level modules register a
driver for the parent device and use its owner pointer to take the module's
refcount. KUnit test suites can now be safely re-enabled even with loadable
module support.

This reverts commit a3fad2e92c76 ("fpga: disable KUnit test suites when
module support is enabled")

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
index d4e55204c092..e4a64815f16d 100644
--- a/drivers/fpga/tests/Kconfig
+++ b/drivers/fpga/tests/Kconfig
@@ -1,6 +1,6 @@
 config FPGA_KUNIT_TESTS
-	bool "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
-	depends on FPGA=y && FPGA_REGION=y && FPGA_BRIDGE=y && KUNIT=y && MODULES=n
+	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
+	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
 	default KUNIT_ALL_TESTS
         help
           This builds unit tests for the FPGA subsystem

base-commit: b7c0e1ecee403a43abc89eb3e75672b01ff2ece9
-- 
2.44.0


