Return-Path: <linux-fpga+bounces-1265-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F4FAEDD7F
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Jun 2025 14:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315F3166089
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Jun 2025 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1E1285C9C;
	Mon, 30 Jun 2025 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLXEPkzY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF83243378;
	Mon, 30 Jun 2025 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287826; cv=none; b=cxNGnKHGtcjcg1QfrvZV+/DxB0BU5WReCcbLgjifi0dF7NfCXBsU19vcybNHc9NnU7vEsKDDlI1ydGGVxdeFqo0me4iDZAdbOt6Q2dUrsSSFWZR7GHJnp0JoLrEHL6Im0Su++aQ+mfdzKGP1TgxxNRHoYclOL+J54qPdW7ROxOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287826; c=relaxed/simple;
	bh=1ry30HSaPyoCH8NX44+sha/2zVgc5ksFO7x3qZhWPcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBNNNiAIueoNRjyuyY3rVeZCIHR/bgNepRCLQX67E/VYdfQ1k1KWHNNP4SLy5upXbjdDuU8xNEf45sUbQ5yG3DLw50+TF/N25BcCe1vhB6JvG4ggoflad/5m4M3jp3dQ2nYESD7sqIUIYquBGg2f/JPg+6F5JkLMnH6TwtbtAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLXEPkzY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747ef5996edso1774742b3a.0;
        Mon, 30 Jun 2025 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751287824; x=1751892624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvcxIOVCr74ZJ+9mueD9krtKcBT0TziWtKZrkUEvt1Y=;
        b=TLXEPkzYaaD1flw3ZCYflfMMFeJ7BwNzsb95YM55yz6ZIkTYk0ckIMHLzye/THkMaS
         ibA8PQom/aKper9dnUdwHOmxcNCf6IA6m7e2nXg0DIRRs3uo2OixzmHG2VtMNs5wUvYQ
         ZX8I6F16eKw/PxnHMEjYNCyWnI9nqJFDXGf+PVvv7POG9LgEygzOuv4doj0b5MvhBNQh
         06YxkswuqistbVUPFZs5klQIRRjQHrZyUCIz3xfkrw1XfDz3Mz/rx701VQOEV0SGgg0v
         rivrmHfCgOqTxlzPnNC9eZJUa/2xC+Gm9/bEq7zGGzatDXHOU+V371X9xb62J+R5lUOL
         E4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751287824; x=1751892624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvcxIOVCr74ZJ+9mueD9krtKcBT0TziWtKZrkUEvt1Y=;
        b=UxMeL7N3/Azm5cCOj3aHgFwmPuMJrYGYoFLldjCmsnaJhH3PJTs1gDX6RuEnHthoYa
         8wZsxlTZh+gtwtqh/VF+btc2pOBI9TiUTqgzow4R4z/D9DC313VF8GZ1eLH4rDUvSIcK
         cw1Ri0uBtDUtyZQg4m1E7yQr1MpoLcVE8zWA+v4pww5/7P712Tz3CQUeaRsAkfpvx9yC
         cMCZ544OsYZY7KMnu12XbKymwP2PWKwbIk8z/cEPQ+gH+SUtGSwF3SnL1Sa8kUNjtnfF
         cNu1UgdQI464dR61BilwJKpK2PEtWtE70+u1D2SdGIoFPxz5QHbrH00h9KCwVo0kdDYx
         xuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzzPsEDB/huY+gu/znEWRfLgElhDERxJWyfesmKGdEB0KZoJyfEtPYS2fKz81yhGYaYbgEEOuHjO8zsJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUh1a35Cp0FtmVjUmWKYK4zMSxToPLe+ZTKoItCGO1OFGwBrZ4
	1uBKTuVAlx5Bg4geujLs6ARFav8umfVNUjkKV29qRUUtKJGKwIekRwIy
X-Gm-Gg: ASbGnctuH82bsWq7tyBEid/7IGHoUk/OO+1ouWG92dDxHyfYJoIaXGY6LlwAf6g4X7H
	TB1+j6XNP7WtTi0K4dn/yk96FEwL2mf55Rcq0s3EAXM4chWxK8Fbi1SdM7r6nPh1dQFDNkF/pYU
	AA6rqAt4lfXzr75Mq06pUJWFtmvqfNc1VqDLT3YExdjo5tft7sWb1m6/+3t7AxxAD+3p1g+NVJ+
	QZ5TpfMOMY6ElaNHVayhEM43ZeRE8wzHrZwtj7BdCeCmdOYcZa7k8Y3jejBpRaNnJ9C7ZwyIlEj
	wEl22ajuStpcXX9Jx9OdDU0mTaSiRYoT7MCWdDgcPFG0UteBsLqigZHyc+TfG0BYRT8b3b1Dk7r
	A1MvMkho/eFPhiWXTXIM=
X-Google-Smtp-Source: AGHT+IG9/9nAYqg9z0wJH0s0jXNq02MM1YjkMaE9bQ8XVq7mhmuXd2OydcFIteqPxF2Nfyx+YFuRhw==
X-Received: by 2002:a05:6a21:1343:b0:21e:eb3a:dc04 with SMTP id adf61e73a8af0-220a12a4e11mr19163816637.3.1751287824076;
        Mon, 30 Jun 2025 05:50:24 -0700 (PDT)
Received: from seokw-960QHA.Davolink ([115.137.3.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56d0002sm9487890b3a.136.2025.06.30.05.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:50:23 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: hao.wu@intel.com,
	trix@redhat.com,
	mdf@kernel.org,
	yilun.xu@intel.com
Cc: linux-fpga@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: [PATCH] fpga: dfl: Replace scnprintf() with sysfs_emit()
Date: Mon, 30 Jun 2025 21:50:18 +0900
Message-ID: <20250630125018.48417-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 drivers/fpga/dfl-afu-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e7338dbe..f2dd4667a43d 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -156,7 +156,7 @@ id_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	int id = port_get_id(fdata);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", id);
+	return sysfs_emit(buf, PAGE_SIZE, "%d\n", id);
 }
 static DEVICE_ATTR_RO(id);
 
@@ -475,7 +475,7 @@ afu_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 	guidh = readq(base + GUID_H);
 	mutex_unlock(&fdata->lock);
 
-	return scnprintf(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
+	return sysfs_emit(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
 }
 static DEVICE_ATTR_RO(afu_id);
 
-- 
2.43.0


