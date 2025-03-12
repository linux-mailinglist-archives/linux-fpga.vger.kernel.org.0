Return-Path: <linux-fpga+bounces-1104-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F61DA5DD40
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Mar 2025 14:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE04F1796C4
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Mar 2025 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EA6236A8B;
	Wed, 12 Mar 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XzToS2AL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275112E7F;
	Wed, 12 Mar 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784518; cv=none; b=gJH3oVIE7jeyTeKzC29WCbKQjNtKZW8vr6NkTwKPuVU6u8VVcaeGjCphjzAxRqeltSRW3DBKH7RkAclpS1nf980xzfygkusX/WxRuRYpoYHC3yzwwbhcaYCExGYyCjwo7I5zLDs46iphbVV7EocoFuAZhuqKESk5mECeIF1FD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784518; c=relaxed/simple;
	bh=BHGEqUBsRjSctZb37VInW2MFE8xUzgQxm0wCEbT3a8o=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=g4BU2kh7/TDo9+mP7KfwDHPJlYVOiW50X808Fsqqil347e3wv9Y/JkCqZL+IFl52RPAKx3MytFT0PLUMTVwVF79RIJPV0t+MM3owYjqK2QDZ1hvWk3uYN6SQBq0UHUXtWF47YQVkI9e6aQACJ0IUruJBZXprNxu1OtkF1lWnP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XzToS2AL; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741784511; x=1742389311; i=markus.elfring@web.de;
	bh=wa2E+e8YKnG1Xs+YxlyJJXzQdlJ5kCk+NRUrDAih9V4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XzToS2ALHajoqXEtPD37x05suc523bwy0gv0fldiMPnf2IVYlmwQ/N7IIFMjS1zY
	 9xuLyBJtplgx6Z+zkyDkYJI79vBny7rymvCJxXSP50SswUquYNisRB2H71l1S+OLC
	 np1WTpA8qV3kVO5oykBAuRiEkpGigsaGGAitGoSoTJKxQE9WlxxJD7st+a4BkG21f
	 2JX8BbD2L4zwcKsqrgxHBayXjwbc2WNrWVuSftr40OXT6/DdnjJZKQP6UcZb+tdxa
	 G7XFMlkwlnRZogpzD3EAF5qt1o11Tjdno863AtpPDjS1Kb4pYvwQqw4ebZpVA7jjA
	 IMfLzrgNCZGmv40uLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0LJ-1u4D8k2HrZ-000oJ9; Wed, 12
 Mar 2025 14:01:51 +0100
Message-ID: <27efccdc-3400-46b9-9359-4b2a6c8254e9@web.de>
Date: Wed, 12 Mar 2025 14:01:48 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qasim Ijaz <qasdev00@gmail.com>, linux-fpga@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Marco Pagani <marpagan@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Russ Weight <russ.weight@linux.dev>, Tom Rix <trix@redhat.com>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
References: <20250311234509.15523-1-qasdev00@gmail.com>
Subject: Re: [PATCH] fpga: fix potential null pointer deref in
 fpga_mgr_test_img_load_sgt()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250311234509.15523-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qRHTGPqNceH8IbA4YcipsJ6jRqi7gyRXpJ/J5IJMJ/4oZLWb+sV
 OuoaGdXteDQMl5G626O/Ne+2E07/FJBJcuS1hO1NYqJwceA7ag+i9f8JutLJtWcPEidcDW2
 cQ+wGcF6HXYTxGgeqnoOWi2CD/FAKdQT2vyXhNPgKJdCvdZ1yCTYnSuqEu2xHG77OiBZP8l
 eoqUr1NLoizc7ezDxRhWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mEMseo+PhIY=;V0O/wxhwV2ei7Wbe26EVhEYz2Vf
 5yheAmTS1xiTVfpdwjTb8KRJ7w01LyQlrMTjTGRqqdNONvomlNm/Y29sBE+7Xxdvc8OrLjRL7
 XtGpZyBDmn4h3P/NCDnJh2UgEf15Xrjn7136zmCYBe1htg4hcC/zFLx7FzXi3OIx1scuGRByf
 +N/hkxGzM+PZd5rQfO4hciRkdwk+YxhvID9zn/+hfpXi96khz7to63qrOGWQe5ErpiKQxMTEn
 s7XnTaM1/tRnVRUcP1l3QVJVc8oH2ZrZW3WD/fr6/7mazR5HON3Nbdxsguc63ytRbX4T0oUDy
 Z9oVWqOhWeLyoGBkmSnKowkEKcgy8pnchY+FKvQmWzoccFfnz+/n6mDh4HlCOVnNqxkRztC3M
 okKnX8F3gds7QJEELQVyppCe/AYu3ddjXHB6FSAKDLag+0czj8Vsnt2B1Fz2S24/TNzJ/NndY
 kkcBKGxzcuSgmLZOycKyEkOFMkber6stepfODSzjr9ToObq2J9+h5TmYcl4ZIeF97IKDz0lxr
 oo9OyTK02d03AXrYNfssxktF3n/IiMvVlqkQvziqmMysofSgphW84fx5A2GWi9iqFOR/EbVXn
 I9aBZsi3GuPhvtu1sxjL1z1DeMmg9vbldd5A7rn+xN5FwTHaEvKTiS6Z/xLiF6JQL5xMIaOwv
 pfsc9Ay7op3DP/S3/xA5LiRuAqkszh4qseWOYZX4JaoZ6DAvq2prbojZK9InF7gChRZzCbrgg
 szxhwBKEXW5vJtiLXcqRO9HIiYFR53sMxzL0sSM3QUhqttdoUgfH7p+ey7oHz4XA3XTgdPMSK
 /19TaFMxRsGBqPE1RygQ1xdEUm9mSaUJc1MZnBqtcaRnh3FZcslRGMNb2cKzVZPel+wOpCyMj
 1AZXEz4iSbYnCKTEAiE3sqA6QV2aZTtv932+d89zXY//5cFrrijTsJpRvG+8We2cE7DRM9cY1
 rB0QqJ9adGvb9sebTXa+9RJMj3BJv/kDlEzvcmT5angAwOUzBU/pwGhbnKQe5yjKvnua4TL8b
 5eoWIhRj0xPEzzMKIINVDG0/RYxUJ9gklMNlWAPfDkYhci2E7cctTBongCaI1HU8okNDEj4M8
 WQ2EzgiqZ6N6/95aga4WuBZCOmon/Dxbuwipxp6zooTsCt2TLLw0Vz5+dY9BFpyzshcgOjpLO
 DgWDnTvDLs8zV9tqzNmZTKbncgsKAnq3giuH1mgE0CyRRrv/FiHzcx4kUGKlKxS3/F2BjDUjE
 sH7zyO+W07rdeQpyLGYfFSOSpW+KoT7nooqJohhPQrhuyo2h/5S8OtG/HHeT7Et+Tes+CHlAq
 RwICmtGBK+afoFREBaU+YBAhHC0aXHwhwGDl5o6Y2EA5wtDHDgDS3mAAr1fPCLSMRvXFZ04M8
 j/v1W8AoTvQCoFYD0xN7uaCRmmoeKXojJpvR/5do0Od8SgXaHCwb/+b7YhDmNv7KH4dQ88dF4
 VI8U6ki0wl5ifZk1i78JaQEihhfk=

=E2=80=A6
> zero it out. If the allocation fails then sgt will be NULL and the
=E2=80=A6
                                 failed?


Can a summary phrase like =E2=80=9CPrevent null pointer dereference
in fpga_mgr_test_img_load_sgt()=E2=80=9D be nicer?

Regards,
Markus

