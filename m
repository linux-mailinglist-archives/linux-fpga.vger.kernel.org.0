Return-Path: <linux-fpga+bounces-531-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB7B8BD30E
	for <lists+linux-fpga@lfdr.de>; Mon,  6 May 2024 18:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EAF1C21204
	for <lists+linux-fpga@lfdr.de>; Mon,  6 May 2024 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0070B156F49;
	Mon,  6 May 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPI4ufJP"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B4156C69
	for <linux-fpga@vger.kernel.org>; Mon,  6 May 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014113; cv=none; b=MQyBSkQEAa7uglQuWZb7FVfeZrxmTlc3h3LHptoo8zLo0ZxlyajK5wO6srHnH3WYZTaFjhk65NvlqjXWbpk4yOwulIgikXnzcLiGlYqdGIzdO9a+TC1imQhetpw7ZTeWjB7oBqcSKqYS16dOvzmzd0GSyxoPlTHraMIjLRPkGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014113; c=relaxed/simple;
	bh=kP6NGaRYgrSE0QhFBjiJtMvuWvrK8Tsknf/C6p4ofYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IF89gz4bRq3DvPjmlsP/xDy4qe5/gXfV8jSwtJ4MOYp3etPIWwG9pUt5I4TY5HNDKmO+kuIUjUC4jH/h8g+AvnDH90miyvYA/V+ySQTSH02bunKDe7+8NYWzPdvst79c4/InnINnuU4Ip5q2DRYPGmw/r07uYvgdaovuTbuJZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPI4ufJP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715014110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pV60bk7MZRaPMf5SburH/KO5Udmwu+vDVJu5cC1oaZ8=;
	b=OPI4ufJPNIBTw+FkphcNZnoxp+XKKSKGT86/uH9WBxh0llL5ggPjKdVAm219AfqWNLpWXu
	+AuJVJvp5lzOnzB37mLXrTfkVswBYTqgMGJ0KMb/AHTcl0nJUC0yKDEYZrXqz2JbD/H48s
	xXgJHg2tVrBuDl2V0KcD/x7wa4jpKRA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-QG7fLEhRMe6jhOuiJpzv-g-1; Mon, 06 May 2024 12:48:28 -0400
X-MC-Unique: QG7fLEhRMe6jhOuiJpzv-g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7928e064fe9so346866485a.2
        for <linux-fpga@vger.kernel.org>; Mon, 06 May 2024 09:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715014108; x=1715618908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pV60bk7MZRaPMf5SburH/KO5Udmwu+vDVJu5cC1oaZ8=;
        b=LX+KtaYUVZTmtGreJaqy9A2rWnUY/QahV3pppc7obgLgouj8iwaOlIH+ec8CgrHqbE
         BJvakp8985FFDvHJMPsqWS0V1GLeukrFCMg2Wd0MZNoVcLLWEd9rYQrdAkMbSQdIaJJ9
         UIvEimvJPjAs/qkzceXk5/eG2gCBxqAQ8Rw0wRWFOEnRtVTqDr2/6oDd2keIQfCOHfSK
         pa9b97m+RaP+kKiJNEWM89qHdwnAR0InxvZfNkkBcwcxR6Mpje4NELzf4REsZjvPiAjh
         iR/cjliRrb5OhBzLyyGi2Ss1T3Z3AYby80hiCvUL6zFEFpnoD12qUxjEY/zv27+JCqv0
         DK6A==
X-Forwarded-Encrypted: i=1; AJvYcCW8ijFJd0GJNNal7j3uQxA4XmjPyw2pxpB8FYJPgYnUkmsF7kvrKkel2urqKBRWLLq93gX5pv77oVTt9D1miNrs0qaFaRzMqZltpg==
X-Gm-Message-State: AOJu0Yz9m5AxPpWM4q/KnBcYouxym1GTEBy8duWp2dH4upbLWkCOzI/N
	5KoB9Ar6lfCKe3Es3ocR3rU+cEy8JK6yB3JgduB7irqs5IgPuDgcrxbgpe5wS+lnEqoPJE0WK1U
	Uv4pPfw8d3WcMubBzN0/0opACwoGDBtyzHrkS6M/N25GfOf7TNJLWie4/rA==
X-Received: by 2002:a05:620a:24d2:b0:790:9b2c:fdb7 with SMTP id m18-20020a05620a24d200b007909b2cfdb7mr15426086qkn.23.1715014107725;
        Mon, 06 May 2024 09:48:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5fMd6KfjPHxQnMUGoDLrgb49or4FLR1tEmn0ACMub0QftRG1DDtyxUkhyXaByZdYaK7khiQ==
X-Received: by 2002:a05:620a:24d2:b0:790:9b2c:fdb7 with SMTP id m18-20020a05620a24d200b007909b2cfdb7mr15426057qkn.23.1715014107272;
        Mon, 06 May 2024 09:48:27 -0700 (PDT)
Received: from klayman.redhat.com (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id b4-20020a05620a0f8400b00792a2036346sm471237qkn.63.2024.05.06.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:48:26 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Revert "fpga: disable KUnit test suites when module support is enabled"
Date: Mon,  6 May 2024 18:48:14 +0200
Message-ID: <20240506164815.31134-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a3fad2e92c76587fe262a1a4a122045b29885354.

The core components of the subsystem no longer assume that low-level
modules register a driver for the parent device and rely on its owner
pointer to take the module's refcount. KUnit test suites can now be safely
re-enabled with loadable module support.

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


