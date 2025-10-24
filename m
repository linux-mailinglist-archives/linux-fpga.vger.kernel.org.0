Return-Path: <linux-fpga+bounces-1387-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 078AFC06FC6
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Oct 2025 17:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2E6A5069FF
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Oct 2025 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BAE254AFF;
	Fri, 24 Oct 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b-kalm-com.20230601.gappssmtp.com header.i=@b-kalm-com.20230601.gappssmtp.com header.b="XFvc8vor"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D23191C2
	for <linux-fpga@vger.kernel.org>; Fri, 24 Oct 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319947; cv=none; b=ac+Juhl/jLUMfpQy/lBvstZRp7cGiS68Rybg+rbdRKrH7rVhkIbD5MmCWGbEb5UPGCJNAAFc+ls5gRCBArbfIonGEU/li/CuWtSUSazLx7BikgMpAr1XtY5siiR7bcEJrV7hg6De0hIPJXVeOxfpsZgSTEL1l9lZ8LcYOiswkqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319947; c=relaxed/simple;
	bh=BciTX6Ux68uryzRE05UN4beQRRyaUdhCSMPFvihcJLs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=saoDMS5Rskl1xwNptX3MVGOL3uT5WtHCj1yXUtVpzDkXMzPTBYF72wYKq+fYkIP3ceDjV/esIDephYTlmDGl+GID36/wZ09H2EEQPdvmSNuG8ecrPRtlsh4NqG8zG7ICEHD6YGwzPHPrbzfR80hsVaCVhn7nIw64iXo4S+lpmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=b-kalm.com; spf=pass smtp.mailfrom=b-kalm.com; dkim=pass (2048-bit key) header.d=b-kalm-com.20230601.gappssmtp.com header.i=@b-kalm-com.20230601.gappssmtp.com header.b=XFvc8vor; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=b-kalm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b-kalm.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42855f80f01so353264f8f.2
        for <linux-fpga@vger.kernel.org>; Fri, 24 Oct 2025 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=b-kalm-com.20230601.gappssmtp.com; s=20230601; t=1761319944; x=1761924744; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZEoET82giKhTmy5g4rFJDghaE9rD04NI0HgpRPQYik=;
        b=XFvc8vorqm26h4Dw+Z3RwRJBeO/J13m0RTsVdOrXw43+mSTNNrnXO7Jrc1WXdHupaO
         r101ob5tnYYRjoJ5r6u28wn5EGlXi04/bQw/gVk1bXsL67x7IZirNmxOKLEIaa/qGqJr
         ZaQr+25AZUQw2ES7EzbW1gkIXu9KtSk28Dag00ayt4jiPGNrb9Uzf3W28XVpYv78bD7B
         7P/vNFqw0C0mjNEJQHd+5TvMYdDEy/0216GNIhnT51GpmcZ6KC5Oytyb3gf2NJ5IWbmi
         f/GO/+W9eUYy4tJGMKCtOJmo8vYGENve+tl0ds1H0VPZzov8K2p+gfAZvaqbgMNtC07P
         bQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319944; x=1761924744;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZEoET82giKhTmy5g4rFJDghaE9rD04NI0HgpRPQYik=;
        b=m/Ylf16fbOIkcw/cOrDodO3rN3d7etdaP/v1Dk8y+9X+7IeW1dDnZexkXhzA2XhJBj
         ll1+vhbOZ7WoM0/e6ySf+CbI3a9QIDBh4Z0fM67mnQ8AkEKUgg4AZUEsj0EtuVzHxZ2Z
         2gooGA/HFvI412dsS+vgvZDaYDLhHD3DMA4LtEC4g9mPKxdesHkIC89sOe1NNbTcZ4cy
         ocDoA+XamBDP5jObKH4Egpa9YLxP5UkEdc6TXG8F9ghNxLz0JHhxEWx7fbKAHucMXyEU
         JByzY1bKzTsXKwsFZuJGl7SWERLKKEqDUmxZnaOfE9lqkuKuXpeCOZ09MvFa216qyNBp
         xEsw==
X-Forwarded-Encrypted: i=1; AJvYcCUqvevBsPQC4AWtnLFLS3QeZvgoTH3rgVj1eY6dHDZx+3bF9B4gUlBqg9NEbwPM8B7+QO45nS/dsD8H@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1JXwdWmtcfk2/Y/ytVwB7o7f7AA9GNYvyYvQh0ZSjxpCb3amb
	qk5NvVszIM6/9JHS/1lQYvhlpwwxe8H8LgXREe1VeCHqHWoylyjtpyW0gZYHx9QyQus=
X-Gm-Gg: ASbGncssMt8sEJ2srfgMF4ClDaqAhIb8dgs7pXNHW7ji6K8fF7eZ5EM52Tdz86vPMs7
	IkdOJyc5VCVmDU5Ldr5kNf+C1YplYQSNbR5YPbJL6X42w7UV6xT9HVQTQHuuirC2LhLyGQJlTV/
	aLZ7Ew5NT+5E64I/Phl34IJ5pRP7zcgrBqapS1TRZ3qff+Wwgm04gUt0lj66FLaRo1Dgzsv/MXq
	vR9IuQ/mbLD6IXhlZXUpkS/TKnHI+xd/oLLd3jzLGcJyOAtjCTeVZ4EjmpWAtktlAc9T4Cw6BF+
	WyU8oBGBjzoO9NGzQcaDUPNHTzFJXO+g4btonb0GIaEdMERxvTXLc5mHDtKYfmJin+aO1GYUXbv
	be6VIEH0wzfDSI0PYAwpRcDxqiS6u1SuDeqjSwdV5VbIyjIUYByCB74I0AujNyyRPjljvlKN1iX
	Kdn/ZTwOSbvA==
X-Google-Smtp-Source: AGHT+IFkYZmoqT/DK4AXCKWtRrvM9dv1rwVNZDFkbldlM0Ga1CTDuJqmg6CGhjQtDE3ctwk3nNQSzw==
X-Received: by 2002:a05:600c:3b9d:b0:46e:5cb5:8ca2 with SMTP id 5b1f17b1804b1-474942bf7b2mr81184345e9.2.1761319943605;
        Fri, 24 Oct 2025 08:32:23 -0700 (PDT)
Received: from nuc ([94.110.157.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm159038135e9.3.2025.10.24.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:32:23 -0700 (PDT)
Date: Fri, 24 Oct 2025 17:32:21 +0200
From: Koen Beel <koen.beel@b-kalm.com>
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org
Subject: [PATCH v2] fpga: zynq-fpga: fix setting pcap to max speed
Message-ID: <aPucBU9cUsUmbMRI@nuc>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The PCAP interface should be set to max speed if the bitstream is not
encrypted. The code comments also show this was the original intended
behavior.

According to the "Zynq 7000 SoC Technical Reference Manual (UG585)" the
reset value of the devcfg control register (XDCFG_CTRL_OFFSET) should be
0x0C006000, so CTRL_PCAP_RATE_EN_MASK (bit 25) should be 0 (= max speed)
at bootup.
However, the devcfg control register reset value seems to be different
in reality, and CTRL_PCAP_RATE_EN_MASK seems to be 1 (= reduced speed)
at bootup.

On top, I don't think it's sane for the driver to just assume a register
has a certain initial value and depend on it.

Fixes: 37784706bf9e ("fpga manager: Adding FPGA Manager support for Xilinx Zynq 7000")
Cc: stable@vger.kernel.org
Signed-off-by: Koen Beel <koen.beel@b-kalm.com>
---
 drivers/fpga/zynq-fpga.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index b7629a0e4813..83030ec1f376 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -344,19 +344,14 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
 
 	/* set configuration register with following options:
 	 * - enable PCAP interface
-	 * - set throughput for maximum speed (if bistream not encrypted)
+	 * - set throughput for maximum speed (if bitstream not encrypted)
 	 * - set CPU in user mode
 	 */
 	ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
-	if (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM)
-		zynq_fpga_write(priv, CTRL_OFFSET,
-				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
-				 | CTRL_PCAP_RATE_EN_MASK | ctrl));
-	else
-		zynq_fpga_write(priv, CTRL_OFFSET,
-				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
-				 | ctrl));
-
+	ctrl |= CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK;
+	FIELD_MODIFY(CTRL_PCAP_RATE_EN_MASK, &ctrl,
+		     (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM) ? 1 : 0);
+	zynq_fpga_write(priv, CTRL_OFFSET, ctrl);
 
 	/* We expect that the command queue is empty right now. */
 	status = zynq_fpga_read(priv, STATUS_OFFSET);
-- 
2.51.0






