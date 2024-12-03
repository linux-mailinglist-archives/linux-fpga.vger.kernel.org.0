Return-Path: <linux-fpga+bounces-974-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91B9E17E7
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Dec 2024 10:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15605281299
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Dec 2024 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753681DFDA7;
	Tue,  3 Dec 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAmjp0am"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBB364AE
	for <linux-fpga@vger.kernel.org>; Tue,  3 Dec 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218766; cv=none; b=ouIyMQLifkhR84SggUS016DMqO7OZQ0JhqDVNE2XAcd/GHQksj6ShMv2bWc/3hYuWvwbfsoiY6mnEGuwKRNTTsvf0WuSehfaHM12WdAyDxd4hjm9ymPUklfAzrnVwCcBzZ8UEC2CBUgxjG/hOts/DckYeTyAk6O2ARydtZEuj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218766; c=relaxed/simple;
	bh=xPAweFM+Of41AmBetbyyiDAui97w0cz//WRGSpldiq4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RafrJuYM8/lZcGhlvD8pjjeFOTckAkNI20jsgvTLDDo0SJ0MVfy1GqtRYeqrLyzwF48XnzPv6ay0LNiBrqu4a8946ZpYPP4+R24pn0gzN3su1sH7iPZI6b1UgwkUNSsTf9ToalhFj1PZdbTPFFtgk3kp9fGtNWMtr4dWVEC9rOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAmjp0am; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so79818451fa.0
        for <linux-fpga@vger.kernel.org>; Tue, 03 Dec 2024 01:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733218763; x=1733823563; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xPAweFM+Of41AmBetbyyiDAui97w0cz//WRGSpldiq4=;
        b=BAmjp0am2QJDoP5vL1nBCzGMdgnVS/EYxQDUCvReaLzJQkFoep3zQ/vs0EpTpa5O01
         DVaqB3puHZyta9OBXazFwKielixoon8slZELjGh18/j+tz/EBapQxXfKs9SsepD7INpu
         6OgAFinUMIh1HnJzVkVoX7VbGwLSX7PjDFCBAT6fKZK4g5QvqInelR0TdsS5ZaKGP0tp
         +W4v3TmKRJOnPV3WDy81nxUJ2QHQDiGG+02u2u4EcRG4YuYTwAvDEsQjVnyKuvRHmnTl
         q8BU2G3iIf3hgSW6JCuljaE2NPbk527UwXXHOL8fUWv334ds9n1HVz9vK7WnFnXmV0x5
         OpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733218763; x=1733823563;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPAweFM+Of41AmBetbyyiDAui97w0cz//WRGSpldiq4=;
        b=SeuKKudZkKZMblD3BjkSVQ1DapFD5Jx7+Xi0ay56uVGPUZKtGjonXmxM+xrRgA6CtH
         Ta6KGMUf1ph0Bpqq9JCK1Mt81Sn0mye5Ar47ifkt/YNu6hoNX3AmbXQV4kBRvB+yMyVh
         OU3Ss3xXIlIvpehU9hp6sVenn80iYcX3OEwd+ZClH+7R5samZDpiiOAomgH25tBxbjNI
         mNLRT4TPTc4mtFVjajYcw+/fdhZOq1i4yK9VCCBLkyctgyKm31RP0k9YImkuQ69JHyAG
         s8sH36faJGCuwOZ6or8PRvC4y6AyC2JYSxqrO8GpAZ2Fqq9XhzTCe2/Zp6Q1JkplIZ4W
         jc4A==
X-Gm-Message-State: AOJu0YxGuJykYiiNerNxa7YLIqCQjH1muooAm6pvpfKkDWnwXzYtkK+J
	7fdpl5jTtbvW4PA0l8gEx9q07RDeefc6PpWLXXoJHCZqfZyWRWydLWwUyVfmDuGE/zwaRHHonUb
	jNhSHu0oCBnRIwuN+/4kICs5pkjw7BOfE
X-Gm-Gg: ASbGncswYxKAm9Z1WXgPp0eB09L0kO/ukyX3YDTjPrxUv4Zwgfd484VUA39PSz8npIm
	eataKHVaWxqVHat10fj+oYECVN8bnGA==
X-Google-Smtp-Source: AGHT+IHk+eDmkEE46L31FgQVIDC55PeUP8C69fpa7m/OrhSNwSTjMZzJpJ3/ZrpVR21xw47ct7zPj4+8XUsQpgWyPiE=
X-Received: by 2002:a05:651c:1988:b0:2ff:a2ba:103d with SMTP id
 38308e7fff4ca-30009b8c32amr15180231fa.0.1733218762245; Tue, 03 Dec 2024
 01:39:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Silvan Murer <silvan.murer@gmail.com>
Date: Tue, 3 Dec 2024 10:39:11 +0100
Message-ID: <CAAGspX9zeoWMC=+gNh7oVgDSYG2qBDsaiRvaxgK5RGpGcP=u6w@mail.gmail.com>
Subject: Use Reserved-Memory in custom device driver
To: linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I write a new device driver which is using a reserved-memory area.
Where I followed the description from
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841683/Linux+Reserved+Memory

The memory reservation in the device tree works as expected. But now
I'm curious about the address mapping in the device driver. In the
prob function I use "memremap()" to get the reserved area remapped
into the virtual memory area of the kernel space (and later on into
user space). Later I work with the virtual address returned from
"memremap()", for that and to understand the kernel functions, I used
"virt_to_phys()" function to convert the vaddr back to the physical
address. Unfortunately, I don't get the same physical address back.

What is wrong there? Or what do I miss? I see a delta of 0x847000
bytes when convert the address back, so where do this come from?

Here is a code sequence used:

paddr = r.start;
vaddr = memremap(paddr, 4096, MEMREMAP_WB);
printk("Allocated reserved memory, vaddr: 0x%0X, paddr: 0x%0X\n",
(u32)vaddr, paddr);
printk("Allocated reserved memory, paddr (2): 0x%0x\n", virt_to_phys(vaddr));


where the output is

[10370.743577] Allocated reserved memory, vaddr: 0xE0847000, paddr: 0x20000000
[10370.750564] Allocated reserved memory, paddr (2): 0x20847000

