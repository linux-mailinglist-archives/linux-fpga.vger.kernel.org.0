Return-Path: <linux-fpga+bounces-809-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A449AC84F
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Oct 2024 12:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF2A28244C
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Oct 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12C1A7262;
	Wed, 23 Oct 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nU7UGMDK"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1462F1A2658;
	Wed, 23 Oct 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680966; cv=none; b=rC+K2Qz0cRk+GR2wjrH3FX7dS3tIxZKXDNYqdNcFNmulBoQpirqQoqaEiBBV5yB2di4qnTRCEAqlwfuJksLISnnAkgd+F7KX5l9++vYPSkWJGbUslMci+TPDJgBmEiT2gdU7x5pjsuCWnASQFlt2mHDEuDgTwzPOcGmxKoaIsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680966; c=relaxed/simple;
	bh=2uZmCdan2XO0Cl6IjNWW2Vbysd7BOfysAd/eGyKtjho=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RYnzOOkL0B3xf6czTm9BcMBiSUvOzWvRLUvmrNSirSxgtrZBAHyqVndMmG/MuflA3BA+tRvupQpKgkfdR/I3ES4ZjZy/nRC/amGXwsuWTSv+gwQo9EQjt+gPFXT2QxTlvtfY5UBIqAHG81tFsZNL6ss5XHYBT+dAGLVdIksgp5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nU7UGMDK; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729680956; x=1729940156;
	bh=2uZmCdan2XO0Cl6IjNWW2Vbysd7BOfysAd/eGyKtjho=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nU7UGMDK8WFIn/KVA5W9N1NEqSwT8UQE0fS8bECjDpD2ZiPAzyyljte+fEi4gpSeP
	 MnGDOCFdknAj583jHSX7ECsALTfg66OszSBNofUJpIsZYnJleMB2UhPiz0fh/hN1Gg
	 t9UQCpjJv+3WmXZTYUKzsNwZU++PSa/pdsuU92YQbbk+YNmprbZQ5ORoIl89u1y1Fv
	 tA+09hbvn4vMvOsPCG+oDWCAxwiQ/fwwYYlrmQfFKs/7bbxnvek/Vo91SXoeMEkPuG
	 xM1psDgryCSiA474uepaqdbzVyWeBaXpXhxEjg0SlqU14v/WvQHco5bRMaBHD/gEHJ
	 Mjp/mmDmcMg2Q==
Date: Wed, 23 Oct 2024 10:55:51 +0000
To: "patches@lists.linux.dev" <patches@lists.linux.dev>
From: jisralbasha <jisralbasha@proton.me>
Cc: "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ntb@lists.linux.dev" <ntb@lists.linux.dev>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "wangyuli@uniontech.com" <wangyuli@uniontech.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various compliance requirements
Message-ID: <CpPiTF0xZwq_zhrYVO2pCA9TxAmJi_zwVBmyl9Z1RHKCjgf332fcmsc86C_1CMaZPNLlIDcvqOIWa1vR2lr2qMaZpcyIisxLqL1IVvq9ZNQ=@proton.me>
Feedback-ID: 94463129:user:proton
X-Pm-Message-ID: 5a8ecfa1aba099d9d2341478826b3c35ab4c778b
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Greg and other LF members,

I'm writing to express my serious concerns about the recent removal of entr=
ies from the MAINTAINERS file without proper explanation. While I understan=
d the statement cited "various compliance requirements," this vague justifi=
cation is deeply troubling.

Blindly complying with demands for obscure changes sets a dangerous precede=
nt. What happens next time? Will we see further removals, modifications, or=
 even additions driven by external pressures rather than the best interests=
 of the project and its community?

This incident raises fundamental questions about the autonomy and integrity=
 of our open-source project. =C2=A0Should we be at the mercy of unspecified=
 "compliance requirements" that could potentially lead to harmful actions, =
such as:

"Update some entries due to various compliance requirements." (and explode =
some Russian laptops like pagers in Lebanon, or disable all intel processor=
s in sanctioned countries).

I strongly urge the LF to reconsider this approach and prioritize transpare=
ncy and community engagement in all decision-making processes. This include=
s providing detailed explanations for any future changes to critical projec=
t files like MAINTAINERS. Additionally, we should explore strategies to mit=
igate external pressures and ensure the long-term health and independence o=
f our project.

P.S. Keep communications public

