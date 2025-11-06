Return-Path: <linux-fpga+bounces-1426-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4B0C3D1FF
	for <lists+linux-fpga@lfdr.de>; Thu, 06 Nov 2025 20:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AD83B51DD
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Nov 2025 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E84434B664;
	Thu,  6 Nov 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzz5XuWL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BC2C326C
	for <linux-fpga@vger.kernel.org>; Thu,  6 Nov 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455598; cv=none; b=otGup5C2/A8UUTdeDfwX8ZDfKhdJGfGGMw+Iw8cAj4i7twYgY5RHgyaut89QR4/e5+t2/kZ5zb+K1T3YxhnXrr6gSgyLAHJ4yxbJ7+Za12j2DJa8aSaG4ZSbr1LcXt6NVLGIXCrYoJ/1dqmmSypCf2RKcnrFSA8IdqNmTFaUfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455598; c=relaxed/simple;
	bh=Qs4c0IHdK7+7fNnVbHGQSNhi6VNHQB3GEJ9toAaE/nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOU/zEONr7M/GcUSa9H150j/ffPP0H8hI3wGKg5HyriSfTqE4/HDxWkL/1tyGtPZlMt6ODgE/RK0LnYNHDi4cTEktZsmL36+gAQujRWKpi8TBnRFzlZ5cuvuRRKFDdUPN4V+al5jNDgU2yfvbSVoL7ixhiZpA+yWLbU8+dJLN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzz5XuWL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b556284db11so986190a12.0
        for <linux-fpga@vger.kernel.org>; Thu, 06 Nov 2025 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762455596; x=1763060396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+laK8JPFZtn61TIS/0OUyeq5YLMySrw9tZvjURq/X4=;
        b=Yzz5XuWL88S+cfVpsh1zbsd0pIYhw8VpkSiZYKGKB12+HkPAYeU7mdz0cSPOtgLq1T
         zD2/5YK6oVEQs0SlSS9PmcmvGgHEZUyc/czSO/ZW9n8B7yT8D1vAmZecKI04f6ZWKmjQ
         AAn79ngD/sbMli47uba8IgMoKsgSqhVs21gDNRSL26uc+Ipb+OP06OSvBEl5vAMSMcef
         A5BOc3/+8ZhBk/kSDyCvRIGlSi/ll1c5J2OXmUwNa5YwOM4eVRE5wNGWrueMBXApkxfd
         gbiuNpaB1aJHU8OQuiJ+Ed6fiKRgGyt8I2XlST6QvL8lnjiPExbk/BDFfQ6OfpHkiYvS
         0DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762455596; x=1763060396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+laK8JPFZtn61TIS/0OUyeq5YLMySrw9tZvjURq/X4=;
        b=OVd5o5SPxkJ/ORGiaOQFecujtrtU0xzjK95iQhigH7IE6pvRs862SQ1+uEaSQ+P8Ml
         HYFveu9f27yM+BeqGxvBrZodvYRGKBybHCpPtFou0tAaxdqnuiLpd8e4+YWvf1X3pKw/
         8ziO7ki9DyH/sdCtLo15hRoPskI8oP2mHxj3tenlRvFeWMUW6orP4CMIPacYWIZHqWNF
         8MnqTkecT7+XIKy0Rjq3KT7I5AZYetZyiCK1YzfuWEbNrPvd7c4rk+igV4rllmUCjJjb
         RZbGltiaz8YwC33X7J6NBBCaPwNeTbBK6x61nV/JfuPEXgOJFAwUIfYrWhsrCxcu+PYz
         WPEA==
X-Gm-Message-State: AOJu0YwoJlqlvwfq3CzpwzDWHgexXAxF/+o+osz/RACVQcNMmSyYSvCu
	GJgOTwLCa//bsKUa1ENWdj4/GkXyrJ0Ph96jaAT/Q9Sp9CsZzP/PPEhYJM5iWA==
X-Gm-Gg: ASbGnctlrh+2Tw1JTcbyhvO1AAz5KlwLHkovzXqDituM2MZ9iU69GTEKlW+f7V/jRO9
	PgkZtQaExmodHPjZset4mIrX1u3xvGCeZvvOmi+3OajC2JhILQ5TMliSxZjuD21BaxWcEpJcZry
	BCa5XoPaQQqjO2j9WR4AZLyvCBrMB6Hj+wC/TwcJRICMy1nr0ksXeJkugmxs5n/+Xr+z0hEG2k9
	u8+zaewwWrsyuzZNFFn+tDQesulehTuLsI4731wmDz0Q3WoUwS+Jyw33EtPXOdc7Z8LaSxjm2fR
	zMy7ki672E0yDPpd8Lzmj0ThezioCGtKXXJfrbKBv1boVRc8+k76L8JtPynuI0j0zpz7+EBipF8
	8qURJmMCJ1o3nLZ/JTO4J1k28UFMw/M/zLYdyX7BjuacT1SCLo5BrUc9aXg==
X-Google-Smtp-Source: AGHT+IHA7g1UwRV+KPwcTwM5NuDpzrq5b4/opgo8G8g11xTavCb0XSmSeOczIqUjxewxtaGpQOXhSA==
X-Received: by 2002:a17:903:234d:b0:295:2276:6704 with SMTP id d9443c01a7336-297c047bd88mr5747925ad.51.1762455595980;
        Thu, 06 Nov 2025 10:59:55 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c92cddsm36647815ad.83.2025.11.06.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:59:55 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] fpga: stratix10-soc: fix compilation + COMPILE_TEST
Date: Thu,  6 Nov 2025 10:59:36 -0800
Message-ID: <20251106185938.6419-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing header and add COMPILE_TEST to prevent future build
failures.

Rosen Penev (2):
  fpga: stratix10-soc: add missing header
  fpga: stratix10-soc: add COMPILE_TEST support

 drivers/fpga/Kconfig         | 2 +-
 drivers/fpga/stratix10-soc.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--
2.51.2


