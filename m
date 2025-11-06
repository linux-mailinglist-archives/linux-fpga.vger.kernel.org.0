Return-Path: <linux-fpga+bounces-1428-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BF8C3D20B
	for <lists+linux-fpga@lfdr.de>; Thu, 06 Nov 2025 20:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CF03B58A1
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Nov 2025 19:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D0354AC8;
	Thu,  6 Nov 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igzo+dvL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A3350D4F
	for <linux-fpga@vger.kernel.org>; Thu,  6 Nov 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455600; cv=none; b=WN/8Ncdcv7vSEQa6rF9bj6k6L90TOu1y8F4QxS/LfFAsuhgKawBQK8UEFR3GOrcTZR3o9FyXKnXbJzA0FLunZnY6lIFlkjfY33lQA9qX7UXdc7L0mIDLkAbY+MfnMr5czpjv9T5OVEX6oa2uEr6XfILhRsRfSD19sOakuV64aAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455600; c=relaxed/simple;
	bh=cMn6KjmzT4TvlXfOcgI4FvDupMo6AkFL6UGvUtlsZls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHqmg4NF6kVngA2IdPxwHMbo5L2ka3nJSRu0bhvrR2teSP767NqxncShVPYDFnlfMwrCPysLTNux0g0095mUJtvRE2zjbchni6AfTdTqdP6m/puPip3T5JfoSkH2Gqpo13U5BGWJpEMafBS2XgF1KjXemDPdOxzjL8ztuuUf68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igzo+dvL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29558061c68so16068865ad.0
        for <linux-fpga@vger.kernel.org>; Thu, 06 Nov 2025 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762455598; x=1763060398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+FK0gOC1mhwN3V0gqoVshsVD11fIkYoJIfW9hejE3Q=;
        b=igzo+dvLRwAjAX7hhu3Q1B6xU6vznzc7WZLG3901QlcWtUEyHI1u+BwgsRSQB5vVRj
         bgNkrAJRV9mUV8aLoGE0ALVs00ONElmnXltMyGDSkLroPMDjAsY6OF2fuUs3/fT/mDov
         rcLQBV9Lqr++mfMWFzp06CHFL8r95bEuLCrb7lON4RBf/hxLfKrfILlAarHn8UeSTYgN
         vGtI1JDsB7hUkpqpOYBhf1EQbv+NOwOjnj1jJWQMe5H+FDvW77KPTAGGp88gYghao7CK
         Q2LhWYQ4u/IocWgj9eGsSofPm5hHzKpuv7xb2dy/anBnEl70EqWhf+Lqe+TNvbQBR6Bj
         xqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762455598; x=1763060398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+FK0gOC1mhwN3V0gqoVshsVD11fIkYoJIfW9hejE3Q=;
        b=FJhFomNkD4yObaAGI/9umhESBfTg0a4u/Ov3FesIIUmG1TUHwoJ3qFabsSEaIb3MYh
         1dzeCW1gisho4/aI53J0ZRK8iDzbemmRhbvxYqIXg0WOFRvG+Lwd9S8KJ4WtHRXuszYI
         heTTDdOIYj5JU/eYJ2im/NYQVccmCV6Ilpsu66MnmHDJTh8/0Ncfdkvlp0ToYW76ppNZ
         HWMAZ946MxhJ+v77N+yIvIY4lBhkjIT+BkjOAXcth8vkrLtNu0GUxXDT5Jw9UImv9kTs
         y+W3aUMjCQi1EmYqXd3wYY+82uW7Xf6keHDNUrAVuYrSHr/bUy5jDAdLPIbZfCtl6mzQ
         Imkw==
X-Gm-Message-State: AOJu0YwRNFkBhEGzFuZF1rfUtk6wA60FR0ARRzFpNl0ESzFkp4yxHlZE
	YlEaOjfn8w0OXVUWZV3wZzi+pkFqpNSBrSw6XNxLb0VF72G5Fo+wUbiQIMc54A==
X-Gm-Gg: ASbGnctyocas5wQkfLWobtYZJMytAN87yupwaeSkQ/7jqIXT45BPa7MSMWwtAd5QZPx
	4Su4OKYxfJNiXGW9raNRY5NiYsQEMXxHJk4uHu/eOvu7ZO07ObAubh1kjozqxjxBIGGkyqSm57I
	9lYcri2lO+oTOqBSzCPAxs/OjyBUJS3FwHNq7HFynJr53GGzLcaYhQG+/hJLNj8t7b4WkP0y+Xw
	muQCsDrJl6QR5ix4i2k6F0BckUmxAX4vKtX7jQqg8lBPJc04s47AAH8ZtdyBMitjGBz8Wj+A4Wp
	Of0doZzjmsJkEt0CXVNFr80Bdu4unI4qp3fhKYTr3ahKvUDhMRN4p02a7fYkqtBW01yvXUKBoXn
	0PZi08cUuZCYGHCqeiG+yldcUM45XvZUvWPXydm31iltBMYhMqOsGW9Ambg==
X-Google-Smtp-Source: AGHT+IHagJSVNCT4R+KJ4Gcu1Y5auKiZ70Unu5mjvH9cLJ9bPgg5yTxEK4O18UgoksnzXKb2DtQKBA==
X-Received: by 2002:a17:902:e945:b0:27e:ec72:f6d with SMTP id d9443c01a7336-297c03a0676mr7775115ad.11.1762455598382;
        Thu, 06 Nov 2025 10:59:58 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c92cddsm36647815ad.83.2025.11.06.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:59:57 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
Date: Thu,  6 Nov 2025 10:59:38 -0800
Message-ID: <20251106185938.6419-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106185938.6419-1-rosenp@gmail.com>
References: <20251106185938.6419-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the buildbots to find compilation issues.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 311313f3b282..f2e2776acdd5 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -60,7 +60,7 @@ config FPGA_MGR_ZYNQ_FPGA
 
 config FPGA_MGR_STRATIX10_SOC
 	tristate "Intel Stratix10 SoC FPGA Manager"
-	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
+	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE) || COMPILE_TEST
 	help
 	  FPGA manager driver support for the Intel Stratix10 SoC.
 
-- 
2.51.2


