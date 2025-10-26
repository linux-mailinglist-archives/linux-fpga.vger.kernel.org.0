Return-Path: <linux-fpga+bounces-1390-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4759C0A662
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Oct 2025 12:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E86C3AA20C
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Oct 2025 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903B1B3930;
	Sun, 26 Oct 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbqbJmbc"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B61411DE
	for <linux-fpga@vger.kernel.org>; Sun, 26 Oct 2025 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761476566; cv=none; b=rhH8xVB70bYgEvfbC9W2C3hHCibzoAr9fgf1+AGwY2VUh5hrVXML6+GjSdZg6bt4hj3G9xp9MxOVrq6XuGSRdh2qwM6b+gXu7jaZjIqvDvwRE35pMX9FOo97OPCY1uKGJtx+WKc/eYCFV1/cWwJVp/B6t40QR6lV0bpWXPkkm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761476566; c=relaxed/simple;
	bh=h75nUbe2eeh1PowgGQW4c6jSTAyoa8d4++dknRdvKRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eo5RDwSjvCESxSqzXRDzsHIXMCpZfFze3sYEAbTOpeMkftmOx2alsszoA+60jiV5FHw2SHlX7HQ84CxaHpIlteEpuVFCiU4Ddu2WX+zeBVOIVoWplSGxz7d0HPdPuqKY1BsZ6fDdIXrmkP3djBgBM7mnnCWzbt7OINP98UAuTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbqbJmbc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6cdba2663dso2598941a12.2
        for <linux-fpga@vger.kernel.org>; Sun, 26 Oct 2025 04:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761476564; x=1762081364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/NU6YWM32W2luhxcCaCyjPS5JSseq4k7NEgR+gYfBkY=;
        b=fbqbJmbcmSfu0iQDiZoLXo72DwlJ/J9sK00NOK+xTaWNkIfFOxnQRoJsQkOtwOYkUk
         Drqu878pExrXbfo4OHkqhFbzqZdAQ8IZoOtcFKQzFSueBD1rVNP6Bh74Yk2iC3bU2pgo
         ViIVa+L9/p1uaxl69FIym9qkbEYfu3I98i4B7QsaEi3SgD9pKk2DaLD7MomDG06+ZGam
         bgq8k3yQE/tpHWDPnLeQSJ2hNKpFVuatgnJPLtvxvZGncTOqwwhxu1m0ekucly6bKWRl
         sVBEOQkK6l0iQ/JJgHuhR6s1NetWnHYhItx7/T3jKvD0lpaCTeHjdakFn5XRSAe5w+Ee
         aLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761476564; x=1762081364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NU6YWM32W2luhxcCaCyjPS5JSseq4k7NEgR+gYfBkY=;
        b=r6jz8b8kRBtURvmC3qiAk87K6Nn0MRGyi3MOeYZrGdW79q3iNUefZKCQeqJ1CKq2dx
         CS/oP00PfOV5Udsbs9YE2k8XnetS1udE+T+CGtLJMBm+o+7HwrWOyIVs3haeHoJLv4Cy
         T145w0ucvYXjOZiGmf+w2ibvLhgoEpdAjsiyOEjXNfC3iE3sspAVJhRa1mwOmvKRl9S2
         xNm79idhO+mSu/+F2RUhjz7Qa1z/agM4elo2nM6AwG2hljpftmirMRwQ9AfSvBi65b9p
         aWjNUQ0KVHfe7ClPEQMhLyyl9/883UQrKc/DjSEW2SmqhNWH7oUuqdUeUCqxMxPtTb5x
         lxQg==
X-Forwarded-Encrypted: i=1; AJvYcCUMjZ6Tfw0YgAjw6+3R6HAgQnDFrRIMBwZ5uBwhbX17iGPvZXrnZAezbbtRqUBuYosmKdON+Buy32tT@vger.kernel.org
X-Gm-Message-State: AOJu0YxZP9sQIVhUOpDEsIBTE6rfWTOLdNTcDGNQceNpQLrYeX1zg/Ib
	fRcX0xOwyjLJj5Tb2bJ3myWlqQLeKsnpvpDn/d33nXxYh/vz2vyTKkQx
X-Gm-Gg: ASbGncsbyHwlN8n6Y/D4U0hztFWhtmPfU7b8LOq4p36sWFglWgig3lQfs2jTMPTrOV6
	7/EhEjyuQ04i5VzKJPWNVjU/yLet8udakuHz0sgtNIo3p7pvfcwOW+5owyJOc7AbDyt18aOkvQ8
	UoA2ZIBS587RlpGbmTn9o1TzfvOLU5oY8LjJFoOND3Ajx9EpTVPBmsepQKm6E5pJtTq8SG0Fi7M
	2HfuYEna+KhCWApZCa2Dggs2ssJsTeZNsxi0j4F79i+DL7TkSET6kI//00e0DxbMUlrsexvGLc1
	rEIzYdBOY80iC7l7qtkSv7DmO071QxDQq+YorzxGkZrh8Uvk/Ns2+bL5ZZIw0eCzM9IenrfkpU0
	Ol+VAcsofmJxASENb2ChJvxYDrFf9tSBsKLVsxO7yJ08eG0z45USGvTWx74RrmGVTls2lkOD+rs
	1hKqkHhUPhOe8w/w==
X-Google-Smtp-Source: AGHT+IGdzB4/IE28Nt/ju6X6+DtH4ujEaOFsqOsu+rW8gU39TYgR+PegJvwQ6VL1znmsAWW3MAS6CQ==
X-Received: by 2002:a17:903:3c24:b0:267:a942:788c with SMTP id d9443c01a7336-290c9c8c5e9mr429195435ad.1.1761476564157;
        Sun, 26 Oct 2025 04:02:44 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2609:1aa3:ccd1:208f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d47ffesm48663175ad.87.2025.10.26.04.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 04:02:43 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: mdf@kernel.org
Cc: yilun.xu@intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] fpga: xilinx-spi: Add missing spi_device_id table
Date: Sun, 26 Oct 2025 08:02:37 -0300
Message-Id: <20251026110237.986279-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "xlnx,fpga-slave-serial" devicetree compatible string currently misses
its SPI device ID entry. Without an spi_device_id table, the driver still
works with device tree, but triggers the following runtime warning when
registered via SPI core:

SPI driver xlnx-slave-spi has no spi_device_id for xlnx,fpga-slave-serial

Fix it by adding a corresponding spi_device_id table entry.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/fpga/xilinx-spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 8756504340de..26348a768bbc 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -57,6 +57,12 @@ static int xilinx_spi_probe(struct spi_device *spi)
 	return xilinx_core_probe(core);
 }
 
+static const struct spi_device_id xilinx_spi_ids[] = {
+	{ "fpga-slave-serial" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, xilinx_spi_ids);
+
 #ifdef CONFIG_OF
 static const struct of_device_id xlnx_spi_of_match[] = {
 	{
@@ -73,6 +79,7 @@ static struct spi_driver xilinx_slave_spi_driver = {
 		.of_match_table = of_match_ptr(xlnx_spi_of_match),
 	},
 	.probe = xilinx_spi_probe,
+	.id_table       = xilinx_spi_ids,
 };
 
 module_spi_driver(xilinx_slave_spi_driver)
-- 
2.34.1


