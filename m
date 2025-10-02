Return-Path: <linux-fpga+bounces-1368-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ED3BB3EB7
	for <lists+linux-fpga@lfdr.de>; Thu, 02 Oct 2025 14:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7BB16B869
	for <lists+linux-fpga@lfdr.de>; Thu,  2 Oct 2025 12:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14223301007;
	Thu,  2 Oct 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b-kalm-com.20230601.gappssmtp.com header.i=@b-kalm-com.20230601.gappssmtp.com header.b="H17TJWfH"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA812B94
	for <linux-fpga@vger.kernel.org>; Thu,  2 Oct 2025 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408925; cv=none; b=SgILyHtZGTeFBLT5Weph7DBvi51qjgkEYHrnZFWHxXzxm4SDSHs9V+SoBtoVLkZfKx/LxTEI3TfUMeeFoa48OJ8aK6nVzn5UAN6YFwocn1Vg30NzpO5Na4t7W41/gWbEhYrRqlXn14eFZgz5OiuRIie/MGAIM8LTYzug2qzDOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408925; c=relaxed/simple;
	bh=N0RP3SeZ5ZOKmGFtWl6hBv5dg4lyvdqX2X2Y1aawfKA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aqhJC79XWjh2iUdzHeTtZLYTEeKONBWFt/hROjO3f1kbziNCqfJpgmm+goRiuVDY1gi2Z5HIZQzEnEfuKLcyCWd+Au0KfFe8C2ppOg1hjvEvncyYIvOeSUoBZNVOesDktjPmGkS6wbnSDGxI6YUM+ETDc11+LOl+yLHQGmChPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b-kalm.com; spf=pass smtp.mailfrom=b-kalm.com; dkim=pass (2048-bit key) header.d=b-kalm-com.20230601.gappssmtp.com header.i=@b-kalm-com.20230601.gappssmtp.com header.b=H17TJWfH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b-kalm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b-kalm.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e310e64f4so1270885e9.3
        for <linux-fpga@vger.kernel.org>; Thu, 02 Oct 2025 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=b-kalm-com.20230601.gappssmtp.com; s=20230601; t=1759408921; x=1760013721; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZ5NARVr7oLt5LjEe9IIXVVcB95yN4amA1RpGPYte7E=;
        b=H17TJWfHNspcXZs4oqt0h8pb9ba9Ah1WNattdHr2cGKR/EQYKTJdzBVS2WpNO5MlI4
         4kNdKIDANhHhEzFtnUUdh1DYcm2CNYQVwet1NK3U1JZDO01SYagNNxp3z0/0lLKr4euJ
         WIH6c95Rs3sXWRYieH58M/VapzD3obecV+Y7/7iz0cfNUy9O0a8p15DIAYIBPW/8Pz7h
         mu3kwPaQrHdy8gK3TXJyvY32e2ctluIE4sWlAdI42Q0aAeDNSeakNEnD+n67Q2C9TfEs
         DIin6E1Bau7XMaUuHr6z6vfuDox7bG2oYcmHwO+poxUUTKZOYUW4dmnQdbC463Yfsn5x
         o0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408921; x=1760013721;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ5NARVr7oLt5LjEe9IIXVVcB95yN4amA1RpGPYte7E=;
        b=A0uMprXATmRab3aajpyb1OPxMsbzCRw8aYy4ydD0mZ6rLk9WpqeYa8EyWNRzihxnaL
         EW6SGabg/fIwmjPsYcXTruMCJ4teUeVMn3lnBaFIN/M/MLjZ9zdXdqOHJf0HJkJ3GW8P
         o02/9Y6SeEnFq5MAiiQOXl5TUXoIkaH2hETbNYEW0K3a/u1Qmzq9Vdnie17wo7HOU2QK
         k1a9sYioZsFkFqjtYFFYaO+wWc6BgOAzVdIoKFqTXAMsbVYzzZI93VofwMQ+uGbeaeId
         H1FTEVPX3Xln7XXFBSJ5RQ4asR+RnhjeFFRzVYKWsHKE1S2WVZnUJKcu1zFfdBXiFGjK
         V1gA==
X-Forwarded-Encrypted: i=1; AJvYcCXsyGU+wWPikbYaHgm6p+sfX19kKneHEa+T6INTGuE3FgLLHwJvTq4xWmjUC2gXSyTBvYOvK+cnBHu9@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQS5BughxBPYzst1dOtls2GXJHW9I4jDzz9s7gWJPprM7p7Kl
	oq7stT2WRsXpU0+B3zHegyl566olHDHja/pjoT/fIMBd8WsTdRSqHw/WutnYIJBNa3Q=
X-Gm-Gg: ASbGncs8WwNm6vqwpOi4j96XusYsZf0Rwb+NHKgUP352RxiiMzXuvC1xGUMO8Pir+a3
	vkb/OCznK3GaqmkEzxk6Cw5pNVEs4pI9uJ56BXcUHID2yic/vklUx9B3FPYw8zBEDUdk01cUw/h
	hDCmivSYIbCU6RZoCdow1UhCnjPM0j2eDGx4i/MmW0+tetT6vh4AvQF8pmTQS6CevWPnCMgZ6Jw
	AmXi9+GRTyZvz3rUt1NN94EW4fZIlpoJ5FaZ9m2IEw1eTkiuytuaR+uy+JC8iMCe/Cbu2OKopbr
	c5UVOre1oZIBvGcWMSS9Vw7o9nLSbhaNc7R9P0gClBHErmXhZ1r2FJJxWS3NAtunWIPLViU5Nb8
	TU72GqWxm3RljgVj82KyI6V3l4VBrJn21hmc=
X-Google-Smtp-Source: AGHT+IEDFDmR/roeMEpILSeQIwcX6OIbayURE6MIp2Y1bXHW6l78YJUKJiqSwn+mYiAuyIDh4EVT+w==
X-Received: by 2002:a05:600c:1908:b0:46e:32d8:3f4f with SMTP id 5b1f17b1804b1-46e612a8152mr27177485e9.8.1759408921343;
        Thu, 02 Oct 2025 05:42:01 -0700 (PDT)
Received: from nuc ([94.110.157.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693bcc2csm33719215e9.12.2025.10.02.05.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:42:01 -0700 (PDT)
Date: Thu, 2 Oct 2025 14:41:59 +0200
From: Koen Beel <koen.beel@b-kalm.com>
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org
Subject: [PATCH] fpga: zynq-fpga: fix setting pcap to max speed
Message-ID: <aN5zF8iaKlPqL9pZ@nuc>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The PCAP interface should be set to max speed if the bitstream is not
encrypted.
The code comments mention this should be done, but it wasn't the case.
On my board, this fixes failure of programming the (non-encrypted)
bitstream.

Signed-off-by: Koen Beel <koen.beel@b-kalm.com>
---
 drivers/fpga/zynq-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index b7629a0e4813..1872ce05b566 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -354,8 +354,8 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
 				 | CTRL_PCAP_RATE_EN_MASK | ctrl));
 	else
 		zynq_fpga_write(priv, CTRL_OFFSET,
-				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
-				 | ctrl));
+				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK | ctrl)
+				 & ~CTRL_PCAP_RATE_EN_MASK);
 
 
 	/* We expect that the command queue is empty right now. */
-- 
2.51.0


