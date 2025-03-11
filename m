Return-Path: <linux-fpga+bounces-1103-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E104A5D355
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Mar 2025 00:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766EF17C183
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Mar 2025 23:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99271E5B68;
	Tue, 11 Mar 2025 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWvnn3IA"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19C199FBA;
	Tue, 11 Mar 2025 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736773; cv=none; b=CA7DrmPv4SXUnZrNXzovidIDtc9efInDY9AKjBvODAItAO4P//VxyZW8rYlxB3b56b6pQnmP5d4sH1oBeL0k3ObbYVY6AMucc/kbm8qXuvLAhjLrc6LbWJ5nts6fuKbqwGfHKKqx02cwww87Ok+x5/6ked9HRJYTQ0cazP/19fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736773; c=relaxed/simple;
	bh=ttKiG7wHF6gWshtsqbOv+5reDG6C9OqvOuRTzgk2XpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=svSW95tKiJBJex3fquh4DMAFOG51O0A6F9qYo5I4AH5vejSNRUt79CDXero/XatzlOk3u2vFVJsGIIcYGuL3z+pVL768T3kHL07vpldC83gcUvYEBoqGl8OQY61IM8gGK+J+z/2sQHPdHdLVi9s9oECDFwwga+X2f/vwkE5G6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWvnn3IA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-391342fc148so3013765f8f.2;
        Tue, 11 Mar 2025 16:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741736770; x=1742341570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSA5D3bpZ1RmUV9svLtPPUiUbdUn4/tyKU5Q242XUNo=;
        b=kWvnn3IAmtPhPZ7v2HOzMxXIEe/KGP23jHKQyLzokbNhahiVBMSyjWF1VmftaJfzP+
         toMH5UXFwO6/+8IqUnkBFafGGkxgFGNpwGAiBYWWsAFqVFVk/YLZhVXCXHhqMxY4n3Uf
         Wz+MOGGwk8l9LDVc1bIhmINcsaAUDGl1DX1VJDWUVg1JUoOgY/0W1PbXtsAw1L7OXekl
         iAyZoqWAUqB0y1UuIU/GMFjArRBuHlGlr29NvCqPD7/Di8mgKyVJXXZcbzmqOa9+/dpp
         vYJ3FiPi8j3K54AJsKDFAU16AYm7sDy2Sy11+lU0KNsLz5erX67NCbjJZPvP+gGmZWVQ
         TASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741736770; x=1742341570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSA5D3bpZ1RmUV9svLtPPUiUbdUn4/tyKU5Q242XUNo=;
        b=QTNDhgXInYwegf1RZGwH9Eku+U6mjWL8gOIKmtmPseI9AUsrSGIVU0KX2aH64xf4tv
         I1/toumRaJ0HTQ8N1gOT323xtWEf48j/EsJiJ1z1jHVSc/fTKt+E1lUgnsy8tScgAS9W
         KRe1YgMnHMggTjPitpmVUf0jak6MUYkxU8fRKI5FqoBgNMRbHNB/6Kf4orlviFTf0gXu
         f6crVsKnyP1OY5FTZxBMoSAtR0tmGht3Trw2ZJaOspr7zOCxsNzr1JTTkpQ7Lom5w1Cd
         txKok6j48w9uXHSMunhX6vP6mYcfNVOAd1FAhbkM+azEE1X5JLkuQlioyGN4eugSBH9Y
         /swA==
X-Forwarded-Encrypted: i=1; AJvYcCUP4uolr1uOmiSQPWCW5ICCkBWIg792UqIlT3eNTZpxxecQ9NeozhiqERwDPCOwpPVU+FmB4vnEtuWcm4E=@vger.kernel.org, AJvYcCXGGQQGVjgVtGvk16m1EUy8tiYw5/25BCGxkln9azu9P9W4emruoNxH05KJJ1nBpd02FkP0ioZN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy14iEG/peNS6F+4WHuZt2lo75wZN5HQrS5nVhpCWKESruzmDOB
	FWk10FiGF4icS0tcgII17wNQaKzibL4/tpqgCz2dXPaPsuKeKZTF
X-Gm-Gg: ASbGncuJsNcDdqnhr8rNoae9yBn0AMbnjJHI+8KnwvYmPprfh1hBSO1697qgnXCiHEA
	nkeAQNCANto+p+jHhndjwzkYgBIhbKCRGPycoQ83edQ1Argwcx66cWM/GX9SLLzB+OM9g8Blshn
	CyLCRuJibdT/lKIDYs+2UbXzxtV+hX+2Ktwf9CUJ3yMosgzyxUdkylGvGr7z9kBCkVuv3xTe8Tv
	OlUVH+STUU2gz/a9Sw9SIQE4a/nbg5UEJk9lxqSAQZEg9Vg75Vg//4dhxtoxBIT9qtJ8CuUSifq
	GTcGxXVhbyWooAymTwMoXwkweqD5PxplLS+dBkbWNYPofw==
X-Google-Smtp-Source: AGHT+IGrZZJavOEsLZYKrgOW3fvlos8fReIB/d8wy/PZ/d5lgrzHeOmwhbsRrF0bqXy79o1crrJaRA==
X-Received: by 2002:a05:6000:2109:b0:391:2d8f:dd56 with SMTP id ffacd0b85a97d-39264694c30mr4198082f8f.29.1741736770176;
        Tue, 11 Mar 2025 16:46:10 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:2519:cfd1:6ecb:2d68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102d76sm19166386f8f.86.2025.03.11.16.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 16:46:09 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	marpagan@redhat.com,
	russ.weight@linux.dev
Cc: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fpga: fix potential null pointer deref in fpga_mgr_test_img_load_sgt()
Date: Tue, 11 Mar 2025 23:45:09 +0000
Message-Id: <20250311234509.15523-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fpga_mgr_test_img_load_sgt() allocates memory for sgt using
kunit_kzalloc() however it does not check if the allocation failed. 
It then passes sgt to sg_alloc_table(), which passes it to
__sg_alloc_table(). This function calls memset() on sgt in an attempt to
zero it out. If the allocation fails then sgt will be NULL and the
memset will trigger a NULL pointer dereference.

Fix this by checking the allocation with KUNIT_ASSERT_NOT_ERR_OR_NULL().

Fixes: ccbc1c302115 ("fpga: add an initial KUnit suite for the FPGA Manager")
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/fpga/tests/fpga-mgr-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
index 9cb37aefbac4..1902ebf5a298 100644
--- a/drivers/fpga/tests/fpga-mgr-test.c
+++ b/drivers/fpga/tests/fpga-mgr-test.c
@@ -263,6 +263,7 @@ static void fpga_mgr_test_img_load_sgt(struct kunit *test)
 	img_buf = init_test_buffer(test, IMAGE_SIZE);
 
 	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	sg_init_one(sgt->sgl, img_buf, IMAGE_SIZE);
-- 
2.39.5


