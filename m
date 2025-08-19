Return-Path: <linux-fpga+bounces-1328-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CC8B2C3BC
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Aug 2025 14:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0294F685B8E
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Aug 2025 12:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3801E3043B8;
	Tue, 19 Aug 2025 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIiiiak/"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FB26FA5B
	for <linux-fpga@vger.kernel.org>; Tue, 19 Aug 2025 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606522; cv=none; b=hnBWUZYE30ww+kCIdMENTsjvT/TltA4z+ElRMfPt5X4QSW0CwhVkQzay9bPt2GV4C6WHrkSFZyOUmoh5X3voLwy88nWQQnYr4jhTBFZEb6FEIpCCCuafVJ2f3u0DKBRP8KDGMySqL0+2MztxiAyK2A9jFkgTT/CjruC2J8deLCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606522; c=relaxed/simple;
	bh=F930J8sPvbsU57FFnW6foQhbn/RAm3RZi0OeYZZPj6I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b2PEdw2gnXOxiaSfh85sX4tF9/a+UsMQF9+HUypE2p2pfIEis75+wLpeUW5LrtCflBCrYpPjApfm3z5iipHpeuw11aNH/QN0Fot0+A/9fgg4IYZFCEeb9CQNlWMCsCjO+0B7CFMzfGs9IKRn8i83bWetQlLXGamFghbCdpVg3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIiiiak/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24457f5835dso55401065ad.0
        for <linux-fpga@vger.kernel.org>; Tue, 19 Aug 2025 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755606520; x=1756211320; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F930J8sPvbsU57FFnW6foQhbn/RAm3RZi0OeYZZPj6I=;
        b=TIiiiak/D9OfoGoX5j6f+/3rmuF0y0Q9JDxU//CLyIhvIJBqid+CXxwOmCsu2FvKJ8
         JChD4k9tsPEGDuPqxC6Jui5dra62QLUlXVAP37sJd+/3lmmHK7zaxuBj9c5wRHGztqqt
         movl5tXKtKr0ddEuY3tne2BX1Tn+58ba+QTpJo2g5K+DNqXXu5tl5dcUbdANBgSdL7Cy
         BnTph3h2/JD7tdzBOt5mlO5qRvzsFMWcGAjyf6OsvhYSxgaOyaD8HnLTnlW63TvzSlIA
         jujiXHwe/HWSD6cVR4uq/EkfHV4K6QPcmhiEYM6+H1XQxTXwxpRqy0EX15hN7FPciCbc
         4RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606520; x=1756211320;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F930J8sPvbsU57FFnW6foQhbn/RAm3RZi0OeYZZPj6I=;
        b=KBWRZEzHISiaoGfv8hJZAC4r2yetgebDsKQ2hnpkGRfaTk7MTuryvPClNC81A6MMvR
         +p0mAlbwYx4yeor9oZJZI/scuG/eaMsn1nzEKnt/TVQzaDF9Aa7o/bI+EftHPlXNsm5O
         XIuOAd7et2MWmkG8PeqkJLl79OhKiSx5EKfUiusQdLmxeRKdtkm60tEbKYMl649FNBm4
         IhnPFhVO9B0NVpDQrqOKep0VqjC4RQjRCmQbXj414bIWQ+AGcMkKW3yfqMto1KbCdPRJ
         F7PE+QNXSr0F4hl7j9V7nUxnJLFmJRcxSQdoGjKBqCBkW5Kf9Lux4eTPazymnZQCzJr1
         QvGg==
X-Gm-Message-State: AOJu0Yyr/1XOaQLUpLTrUAXUmZ07Iuu9wVrUITWiXuIaXl5xmSuIbzsr
	WFRjdvK5TNXW4B2NQ7QaP6oxEPhvODaG4DLxLTcZ2RLAYiR2kXqRIE8DsUlbg4rBaEkK0JUV85k
	bdQCFlf9NAEXU+X1HTg+UB94x/+LmWRuUWAXn
X-Gm-Gg: ASbGncvIGxfj0L8aSPE/8xgDpgdOxY2ktJPbamaXZlVygeYAOd2xomNPGwxotuQv8p6
	XVdBd1CXyJD9P5YZkLk8RkVvnFjkV9bQ+bPlEbGsmeJAhHi6yBMdxDVE4F5rTEOONOWm21ttW0s
	ra/GThiH3P6D8xMrkU91jm1mBeTauZTNeuqCh+P8tzAUzKZvhUf7tm2GYsplFlL6UO5BNKLiRmR
	86Bfw==
X-Google-Smtp-Source: AGHT+IFfVomrga1smFOqnAvQd7BfhGowk0V0w+3aGWh/pkaRsURiARTa4/o8I9tEJxDkEVNPa1SKSFoqaMwohl9Q3Cw=
X-Received: by 2002:a17:903:196b:b0:240:640a:b2e4 with SMTP id
 d9443c01a7336-245e04df64cmr30356755ad.49.1755606519696; Tue, 19 Aug 2025
 05:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Patryk <pbiel7@gmail.com>
Date: Tue, 19 Aug 2025 14:28:28 +0200
X-Gm-Features: Ac12FXxUFf5IwJnhY6zkr1gLlQeyUzEzm_ssIACtrEuY4SGgQX26OqTiAmQWXl8
Message-ID: <CA+DkFDbzx+0CJVjdOGkah3amqZ8VHE6_-e-eq03-QT3bB0DSVw@mail.gmail.com>
Subject: FPGA-HPS DDR contention on Agilex5 SoC while running Linux
To: linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I=E2=80=99m working on a device based on an Agilex5 SoC with HPS, which is =
new
hardware for me.

I've been considering the following scenario: the FPGA and HPS will
share DDR memory, and Linux is running on the HPS at the same time.
The FPGA will be streaming a high volume of data that needs to be
consumed by a userspace program on the CPU.

I=E2=80=99m concerned that if the FPGA saturates the memory interconnect, t=
he
kernel might struggle to perform memory allocations or other
transactions for other threads.

Has anyone encountered this kind of bus contention on Agilex/SoC
platforms? What strategies do you use to prevent FPGA traffic from
starving HPS memory accesses while Linux is running? Also, is there
any recommendation / strategy for an FPGA and a userspace program on
Linux to exchange data efficiently and safely in this kind of setup?

I don't expect in-depth answers, and will be grateful for anything
that will channel me in the right direction.

Best regards
Patryk

