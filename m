Return-Path: <linux-fpga+bounces-520-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B773E8B59B8
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Apr 2024 15:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FBA1C21315
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Apr 2024 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216854FAB;
	Mon, 29 Apr 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXRZB7he"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE46FE14;
	Mon, 29 Apr 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396720; cv=none; b=XdTIbbVwsFnRb6IH7kiAVcNlG7idga/eH8REeAxREXFoL34DNBYu+WMyZDuhQl1A1ubH2UxMVC/smm9hOP7h4/L8afI76HhZhd8jmsN+/z5Lka6UHin2qaGMNQwkykpzWr858qlA5jBd91PgFfUTSfSz7D0jyRlAywrw3fOMsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396720; c=relaxed/simple;
	bh=GzTVP+cnONGx8I7Xig2IilKrZZe4Kz4khWj5HS9ejQ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YVhuAx7vpb8Qu0cVhlhEiI9V6EWcyRQ5Daj1M0kWN/JO3qbifoJiRj5dc/SMF7QM3MoHprlYuXoT+FNfNs5GSgm4X53x1JYNfU4Zrlscnt+vmSs7/keYzoaCjazYK8sHmF958ZZ2CfhPY3fT7u92bpJgVnbIkVWOtqhzHMnIlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXRZB7he; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61acfd3fd3fso47671687b3.1;
        Mon, 29 Apr 2024 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714396718; x=1715001518; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5DrNmX/O5hzyTD3oW2jtllNOsgM2WyrTONwfmemwKBA=;
        b=DXRZB7heafHsCDeWZUcoz+RaZrEqIBdJBDJVEwws1cN5+SmJUGM4RAj8ZXzS4+yhzw
         evndIs2FiQianPEz0yAyq1Fj0+HAS6MAvsbQ7badJzRWkCSvchBXSbVdJj9PjC/l/6Oo
         5OLei1LhMBhAFnfgqd8nL3UPTRdQVBEMqWpEZXAZWhj8zUn4k8A7jlFjmELL0fpCfEiE
         gvNGdZ22YJXo9ha7SqijFL9/IRXsHtDxwKZGbF58X1k9GEGD2cwynRpEow9PQh3V9dvB
         IsycfsfzakikzBjXiTrm2XuM4ndC8yX1kw+wP/+5CnEQO2eJhexaoVW5gqUAmsh+MglI
         DhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714396718; x=1715001518;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DrNmX/O5hzyTD3oW2jtllNOsgM2WyrTONwfmemwKBA=;
        b=thb+nJGQFP2MqVSQwZoCeDkk93cY1MxbzSTCAat7vHcZ8vAhaXG0Ir6xH16aNyxFHq
         F+4ukGraahjnoJRj2cr5oqFgIofYptLKHrIQyDbfp5ks6m6dNJrGhG1RbIE7nMrgZm8U
         Wsh/docet/3GXHD+frcM7Cqw7RK8Gc8iNAeeyi9tYmuUD229eEBawTCQMMeK8+fc3RaZ
         9yNMcw3fEUCdWeWNm9Cmvr7utuyS1NUSmKxeXgjTELIgMx5vobY+lInMAzHOVhAeM2xA
         d/5KHaUrE0MGkK0KyyEumv2FnTln0J26oyP4viuZszaTsXS6AVSNF1KlAXOXh2FSKZ+n
         jN8w==
X-Forwarded-Encrypted: i=1; AJvYcCUYectS4huaYIRnsZo9s8xL6e2VrrfgT93qcb8qZ31X8VttWHJfVqc8MM0QUxoXZI6ahw6wfyzKA/IKPq2u2DJ471tUASBNuoofww==
X-Gm-Message-State: AOJu0YwC458a02FwW9aD1m6NL3XVLpsf6z1FD/xjsgthhU59FTXDZ4+O
	3GcDpgmZnE8ELgu023pPEssLdLrSm256ZuenQuf14tQBQs5iuKzzlw8U0+Gf14yPGP+QdCLjLDQ
	1x5qRLWkFO+1BPMKkpFDzfzcz8gEXz5Kb
X-Google-Smtp-Source: AGHT+IEEajCrlUb/3QTkb1ktXcly7kvHKmpfcjOnXNtOR6EpLBkfPPxV+knLS1Jw2S5EO2KTYc1niTKx5bbX+gOT3RA=
X-Received: by 2002:a05:690c:387:b0:61a:e947:550d with SMTP id
 bh7-20020a05690c038700b0061ae947550dmr10138549ywb.44.1714396717862; Mon, 29
 Apr 2024 06:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Mon, 29 Apr 2024 18:48:26 +0530
Message-ID: <CAHhAz+iHtWqhvwa_dmTUv+mZhnZ2zHX0W53wDGF+uHhcgk7Gcg@mail.gmail.com>
Subject: ALSA: Digital Microphone
To: linux-sound@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>, 
	linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

We have a Digital Microphone block on a Xilinx FPGA board connected to
x86 host CPU through PCIe, it basically emulates a Microphone sending
data to DUT(device under test) in PDM format.

Input to the Digital Microphone block is Signed 32-bit PCM sample.
Xilinx FPGA code has logic to convert PCM samples to PDM with a
Sigma-Delta Converter.

Could you kindly recommend any specific ALSA driver within the Linux
kernel that matches with my hardware setup.

 Additionally, if there are any relevant documentation or community
discussions that you could point me to, it would be immensely helpful.


-- 
Thanks,
Sekhar

